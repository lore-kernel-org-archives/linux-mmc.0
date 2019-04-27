From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 7/7] mmc: meson-gx: add signal resampling tuning
Date: Sat, 27 Apr 2019 22:09:30 +0200
Message-ID: <CAFBinCB4BC01=ryTPAc77RbKucMRhQNUN-9C++=pM_u=dFYK6w@mail.gmail.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com> <20190423090235.17244-8-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423090235.17244-8-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 23, 2019 at 11:03 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Use signal resampling tuning for the UHS and HS200 modes.
> Instead of trying to get the *best* resampling setting with complex
> window calculation, we just stop on the first working setting.
>
> If the tuning setting later proves unstable, we will just continue the
> tuning where we left it.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
[Khadas VIM now shows the HS200 eMMC]
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


BEFORE (no patches from this series applied):
# dmesg | grep mmc1
(no output)

AFTER (all 7 patches from this series applied):
# dmesg | grep mmc1
[    2.945155] mmc1: new HS200 MMC card at address 0001
[    2.957737] mmcblk1: mmc1:0001 AWPD3R 14.6 GiB
[    2.966278] mmcblk1boot0: mmc1:0001 AWPD3R partition 1 4.00 MiB
[    2.976114] mmcblk1boot1: mmc1:0001 AWPD3R partition 2 4.00 MiB
[    2.986354] mmcblk1rpmb: mmc1:0001 AWPD3R partition 3 4.00 MiB,
chardev (241:0)


Regards
Martin
