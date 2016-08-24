From: Karsten Merker <merker@debian.org>
Subject: Re: [PATCH v2 2/2] MMC: meson: initial support for GXBB platforms
Date: Wed, 24 Aug 2016 14:53:16 +0200
Message-ID: <20160824125316.GA9732@excalibur.cnev.de>
References: <20160803231843.23012-1-khilman@baylibre.com>
 <20160803231843.23012-2-khilman@baylibre.com>
 <CAPDyKFpPCkCRB436zdZ664st9xwA6wTWkFtT=U4HTwwAn-_emg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:50538 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753295AbcHXMyM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Aug 2016 08:54:12 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFpPCkCRB436zdZ664st9xwA6wTWkFtT=U4HTwwAn-_emg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Xing Wu <xing.xu@amlogic.com>, Victor Wan <victor.wan@amlogic.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org, Jerry Cao <jerry.cao@amlogic.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Aug 24, 2016 at 01:53:08PM +0200, Ulf Hansson wrote:
> On 4 August 2016 at 01:18, Kevin Hilman <khilman@baylibre.com> wrote:
> > Initial support for the SD/eMMC controller in the Amlogic S905/GXBB
> > family of SoCs.
> >
> > Currently working for the SD and eMMC interfaces, but not yet tested
> > for SDIO.
> >
> > Tested external SD card and internal eMMC on meson-gxbb-p200 and
> > meson-gxbb-odroidc2.
> >
> > Signed-off-by: Kevin Hilman <khilman@baylibre.com>
[...]
> > @@ -0,0 +1,918 @@
> > +/*
> > + * This file is provided under a dual BSD/GPLv2 license.  When using or
> > + * redistributing this file, you may do so under either license.
> > + *
> > + * GPL LICENSE SUMMARY
> > + *
> > + * Copyright (c) 2016 BayLibre, SAS.
> > + * Author: Kevin Hilman <khilman@baylibre.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of version 2 of the GNU General Public License as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> > + * The full GNU General Public License is included in this distribution
> > + * in the file called COPYING.
> > + *
> > + * BSD LICENSE
> > + *
> > + * Copyright (c) 2016 BayLibre, SAS.
> > + * Author: Kevin Hilman <khilman@baylibre.com>
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions
> > + * are met:
> > + *
> > + *   * Redistributions of source code must retain the above copyright
> > + *     notice, this list of conditions and the following disclaimer.
> > + *   * Redistributions in binary form must reproduce the above copyright
> > + *     notice, this list of conditions and the following disclaimer in
> > + *     the documentation and/or other materials provided with the
> > + *     distribution.
> > + *   * Neither the name of Intel Corporation nor the names of its
> > + *     contributors may be used to endorse or promote products derived
> > + *     from this software without specific prior written permission.
> > + *
> > + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> > + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> > + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> > + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> > + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> > + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> > + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> > + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> > + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> > + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > + */
> 
> Lots of licence text. Isn't it enough to state dual BSD/GPLv2?

At least with regard to the BSD license part it probably isn't. 
There is only one canonical "GPLv2" (a copy of which is included
in the kernel tree), but there are quite a number of different
variants of the "BSD" license:

- 4-clause BSD license (with "advertising clause" and
                        with "endorsement clause")
- 3-clause BSD license (without "advertising clause", but
                        with "endorsement clause")
- 2-clause BSD license (without "advertising clause" and
                        without "endorsement clause")

In addition to the these three major types, the exact terms of
the "endorsement clause" can vary quite a bit.

While being at the topic of the "endorsement clause": Is there a
particular reason for Intel being explicitly named here (e.g. 
because the code is based on some previously existing code which
is licensed with this specific wording)?

Regards,
Karsten
-- 
Gem. Par. 28 Abs. 4 Bundesdatenschutzgesetz widerspreche ich der Nutzung
sowie der Weitergabe meiner personenbezogenen Daten für Zwecke der
Werbung sowie der Markt- oder Meinungsforschung.
