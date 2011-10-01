/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 3.0
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is the ArmageddonEngine library.
 *
 * The Initial Developer of the Original Code is
 * Vladimir Panteleev <vladimir@thecybershadow.net>
 * Portions created by the Initial Developer are Copyright (C) 2011
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *
 * Alternatively, the contents of this file may be used under the terms of the
 * GNU General Public License Version 3 (the "GPL") or later, in which case
 * the provisions of the GPL are applicable instead of those above. If you
 * wish to allow use of your version of this file only under the terms of the
 * GPL, and not to allow others to use your version of this file under the
 * terms of the MPL, indicate your decision by deleting the provisions above
 * and replace them with the notice and other provisions required by the GPL.
 * If you do not delete the provisions above, a recipient may use your version
 * of this file under the terms of either the MPL or the GPL.
 *
 * ***** END LICENSE BLOCK ***** */

module ae.ui.video.surface;

/// Abstract class for a video surface.
class Surface
{
	/// BGRX/BGRA-only.
	struct Bitmap
	{
		uint* pixels;
		uint w, h, stride;

		uint* pixelPtr(uint x, uint y)
		{
			assert(x<w && y<h);
			return cast(uint*)(cast(ubyte*)pixels + y*stride) + x;
		}

		uint opIndex(uint x, uint y)
		{
			return *pixelPtr(x, y);
		}

		void opIndexAssign(uint value, uint x, uint y)
		{
			*pixelPtr(x, y) = value;
		}
	}

	/// Lock a 32-bit, BGRX/BGRA surface
	// We could do some RAII here to automate unlocking, but it will probably get
	// in the way of bundle rendering
	abstract Bitmap lock();

	abstract void unlock();
}