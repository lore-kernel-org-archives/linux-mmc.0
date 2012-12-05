From: "Shen, Jackey" <Jackey.Shen@amd.com>
Subject: RE: [PATCH v1 2/3] mmc: sdio: Fix SDIO 3.0 UHS-I initialization
 sequence
Date: Wed, 5 Dec 2012 05:17:17 +0000
Message-ID: <0C8FBB70FF40A94D98BE847F9C171A98033FE4EE@SCYBEXDAG04.amd.com>
References: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org>
 <1354620980-23764-3-git-send-email-subhashj@codeaurora.org>
 <477F20668A386D41ADCC57781B1F70430D13A09A1A@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F70430D13A09A1A@SC-VEXCH1.marvell.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bing Zhao <bzhao@marvell.com>, Subhash Jadavani <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi Bing,

The function mmc_host_uhs() will return false and never set bit[24] (S18R) for SDIO 2.0 cards.

Thanks,
Jackey

-----Original Message-----
From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Bing Zhao
Sent: Wednesday, December 05, 2012 5:14 AM
To: Subhash Jadavani; linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org; Sujit Reddy Thumma
Subject: RE: [PATCH v1 2/3] mmc: sdio: Fix SDIO 3.0 UHS-I initialization sequence

Hi,

> From: Sujit Reddy Thumma <sthumma@codeaurora.org>
> 
> According to UHS-I initialization sequence for SDIO 3.0 cards, the 
> host must set bit[24] (S18R) of OCR register during OCR handshake to 
> know whether the SDIO card is capable of doing 1.8V I/O.

In SDIO 2.0 spec, bit[24] is reserved, "shall be set to 0".
Setting it to 1 might cause side effect to 2.0 cards.
Perhaps using a quirk for S18R is more suitable for all combinations.

Regards,
Bing

> 
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> ---
>  drivers/mmc/core/sdio.c  |   22 +++++++++++-----------
>  include/linux/mmc/host.h |    8 ++++++++
>  2 files changed, 19 insertions(+), 11 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
