From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH v1 2/3] mmc: sdio: Fix SDIO 3.0 UHS-I initialization sequence
Date: Fri, 7 Dec 2012 09:42:58 +0100
Message-ID: <CA+20K0BRmEC5=SySHE3SxF=VU-uD0WATrgsUGYOLN2ZrAcL-nA@mail.gmail.com>
References: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org>
	<1354620980-23764-3-git-send-email-subhashj@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1354620980-23764-3-git-send-email-subhashj@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sujit Reddy Thumma <sthumma@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

2012/12/4 Subhash Jadavani <subhashj@codeaurora.org>:
> From: Sujit Reddy Thumma <sthumma@codeaurora.org>
>
> According to UHS-I initialization sequence for SDIO 3.0 cards,
> the host must set bit[24] (S18R) of OCR register during OCR
> handshake to know whether the SDIO card is capable of doing
> 1.8V I/O.
>

Reviewed-By: Johan Rudholm <johan.rudholm@stericsson.com>
