From: Bing Zhao <bzhao@marvell.com>
Subject: RE: [PATCH v1 2/3] mmc: sdio: Fix SDIO 3.0 UHS-I initialization
 sequence
Date: Tue, 4 Dec 2012 13:14:21 -0800
Message-ID: <477F20668A386D41ADCC57781B1F70430D13A09A1A@SC-VEXCH1.marvell.com>
References: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org>
 <1354620980-23764-3-git-send-email-subhashj@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:35118 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752516Ab2LDVO1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Dec 2012 16:14:27 -0500
In-Reply-To: <1354620980-23764-3-git-send-email-subhashj@codeaurora.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>

Hi,

> From: Sujit Reddy Thumma <sthumma@codeaurora.org>
> 
> According to UHS-I initialization sequence for SDIO 3.0 cards,
> the host must set bit[24] (S18R) of OCR register during OCR
> handshake to know whether the SDIO card is capable of doing
> 1.8V I/O.

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

