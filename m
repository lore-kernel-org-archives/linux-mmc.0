From: Marcus Overhagen <marcus.overhagen@gmail.com>
Subject: Re: [BUG] mfd: rtsx_usb data corruption with SDCX microsd
Date: Wed, 21 Oct 2015 22:23:50 +0200
Message-ID: <CAJBHPojukOEtQDzT4MS_a62hxPMarNTRJf4OjpSATUx1ismZRQ@mail.gmail.com>
References: <CAJBHPohRA7T573AaZa2sMbyQspaV3KnUWNHcmVM5HzDh+xszYw@mail.gmail.com>
	<CAPDyKFomPVogHwHe7pBTUptW=Ge8nrUeE_DXP4Na8k1UsXxcLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFomPVogHwHe7pBTUptW=Ge8nrUeE_DXP4Na8k1UsXxcLQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Roger Tseng <rogerable@realtek.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-usb@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 21, 2015 at 2:02 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> were added in Linux 3.16. Perhaps you can verify if this is a regression or not!?
I will try this.

> Have you tried other SDXC cards which supports the "ultra high speed SDR50" mode?
I think only have a single large card that supports this mode.
Although I have some older 32 and 8 GB cards that I will test, I don't
expect them to support that mode.

> If you re-build the kernel and make changes around which MMC_CAPS the
I will try that during the weekend

> Sorry, not being able to help you more - but at least this is a start!
Thank you for your response, I'll report my findings back next week.

regards
Marcus
