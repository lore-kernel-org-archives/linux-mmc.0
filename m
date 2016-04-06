From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [bisect] Merge tag 'mmc-v4.6' of
 git://git.linaro.org/people/ulf.hansson/mmc (was [GIT PULL] MMC for v.4.6)
Date: Tue, 5 Apr 2016 17:24:57 -0700
Message-ID: <57045759.70308@hurleysoftware.com>
References: <CAPDyKFqM1ffAdj7jVJmcPW2Wxy88Mhx_UrAzyuXpKSJg1yUPdg@mail.gmail.com>
 <57008645.4070808@hurleysoftware.com>
 <CA+55aFwjQP25NYfjPMTicO-M8yjm5c0aKFx-1saWmrro0c0NVQ@mail.gmail.com>
 <CAPDyKFr6zCm4wBS97bUCwq4qhsM8u3mEpyBf4uicJ_UQ7L-q5w@mail.gmail.com>
 <CA+55aFwFVBg5joDd0QYjmSA6t8TM7tmZvmcArZu3Ar8u4vDecw@mail.gmail.com>
 <CAPDyKFqFoJybrr4dBt8xO7iHt9CAbET=i-v9ZLht7J6K091Phw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqFoJybrr4dBt8xO7iHt9CAbET=i-v9ZLht7J6K091Phw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 04/05/2016 01:59 AM, Ulf Hansson wrote:
> Although, what puzzles me around this particular issue, is how an SoC
> configuration can rely on this fragile behaviour.
> All you have to do to break the assumption of fixed mmcblk ids, is to
> boot with an SD card inserted and then without. Perhaps these SoCs
> just doesn't support this use case!?

Both configurations boot reliably; without the uSD inserted, the
boot and root partitions on the eMMC are booted instead.

Without a uSD inserted, the only mmc block device is the eMMC which is
/dev/mmcblk0, and the root partition is still /dev/mmcblk0p2.

Note though that this particular bootscript can load add'l bootscripts
from the boot partition; in this particular case, the eMMC root
partition is set as a fixed UUID in the bootscript from the
boot partition.

Regards,
Peter Hurley
