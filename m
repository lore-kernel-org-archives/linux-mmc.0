From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: Add support for JMicron 388 SD/MMC controller
Date: Thu, 9 Dec 2010 01:38:43 +0000
Message-ID: <20101209013843.GA19741@void.printf.net>
References: <s5h7hfk3aap.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h7hfk3aap.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Aries Lee <arieslee@jmicron.com>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

Hi Takashi,

On Wed, Dec 08, 2010 at 10:04:30AM +0100, Takashi Iwai wrote:
> JMicron 388 SD/MMC combo controller supports the 1.8V low-voltage for
> SD, but MMC doesn't work with the low-voltage, resulting in an error
> at probing.
> 
> This patch adds the support for multiple voltage mask per device type,
> so that SD works with 1.8V while MMC forces 3.3V.  Here new ocr_avail_*
> fields for each device are introduced, so that the actual OCR mask is
> switched dynamically.
> 
> Also, the restriction of low-voltage in core/sd.c is removed when the
> bit is allowed explicitly via ocr_avail_sd mask.
> 
> This patch was rewritten from scratch based on Aries' original code.
> 
> Signed-off-by: Aries Lee <arieslee@jmicron.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Looks good, pushed to mmc-next for .38.  Thanks!

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
