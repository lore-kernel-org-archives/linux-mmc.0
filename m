From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 2/3] mmc: sdio: Fix SDIO 3.0 UHS-I initialization sequence
Date: Fri, 7 Dec 2012 10:57:36 +0100
Message-ID: <CAPDyKFq2XNpx6RLqyJg+OvAOuTHvAMUOVrKxP-JBBf3hXYWDAQ@mail.gmail.com>
References: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org>
	<1354620980-23764-3-git-send-email-subhashj@codeaurora.org>
	<CA+20K0BRmEC5=SySHE3SxF=VU-uD0WATrgsUGYOLN2ZrAcL-nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CA+20K0BRmEC5=SySHE3SxF=VU-uD0WATrgsUGYOLN2ZrAcL-nA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sujit Reddy Thumma <sthumma@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On 7 December 2012 09:42, Johan Rudholm <jrudholm@gmail.com> wrote:
> Hi,
>
> 2012/12/4 Subhash Jadavani <subhashj@codeaurora.org>:
>> From: Sujit Reddy Thumma <sthumma@codeaurora.org>
>>
>> According to UHS-I initialization sequence for SDIO 3.0 cards,
>> the host must set bit[24] (S18R) of OCR register during OCR
>> handshake to know whether the SDIO card is capable of doing
>> 1.8V I/O.
>>
>
> Reviewed-By: Johan Rudholm <johan.rudholm@stericsson.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
