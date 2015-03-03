From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH v2 6/8] mmc: sdhci-st: Update the quirks for this controller.
Date: Tue, 3 Mar 2015 11:57:47 +0100
Message-ID: <54F593AB.5080400@st.com>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org> <1424956227-18258-7-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424956227-18258-7-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-mmc@vger.kernel.org


On 02/26/2015 02:10 PM, Peter Griffin wrote:
> Some additional quirks need to be enabled now we support UHS
> modes. This avoids some spurious warnings like
>
> "Got data interrupt 0x00000002 even though no data operation was in progress"
>
> Testing on stih410-b2120 board achieves the following speeds
> with HS200 eMMC card.
>
> max-frequency = 200Mhz
> /dev/mmcblk0p1:
>   Timing buffered disk reads: 270 MB in  3.02 seconds =  89.54 MB/sec
>
> max-frequency = 100Mhz
> root@debian-armhf:~# hdparm -t /dev/mmcblk0p1
> /dev/mmcblk0p1:
>   Timing buffered disk reads: 210 MB in  3.00 seconds =  70.00 MB/sec
>
> max-frequency = 50Mhz
> root@debian-armhf:~# hdparm -t /dev/mmcblk0p1
> /dev/mmcblk0p1:
>   Timing buffered disk reads: 118 MB in  3.00 seconds =  39.28 MB/sec
>
> This is better than the 3.10 kernel which achieves 77.59 MB/sec
> at 200Mhz clock (same board/soc/eMMC).
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>   drivers/mmc/host/sdhci-st.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
