From: =?UTF-8?Q?Beno=c3=aet_Th=c3=a9baudeau?= <benoit@wsystem.com>
Subject: Re: [PATCH 4/4] mmc: sdhci-esdhc-imx: Remove the ENGcm07207
 workaround
Date: Mon, 29 May 2017 18:39:01 +0200
Message-ID: <e586c2d4-5216-a5df-ebbb-89873825d545@wsystem.com>
References: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
 <1493805925-3644-4-git-send-email-benoit@wsystem.com>
 <b5c8c521-c2a7-89bf-8c36-519558079464@intel.com>
 <CAPDyKFo1Z-h_Ebr2FR4UvD_RuwfyOWGBk=6wc-GCRwdiqg-pnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from authsmtp75.register.it ([195.110.101.59]:44194 "EHLO
        authsmtp.register.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750921AbdE2QjE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 May 2017 12:39:04 -0400
In-Reply-To: <CAPDyKFo1Z-h_Ebr2FR4UvD_RuwfyOWGBk=6wc-GCRwdiqg-pnQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Wolfram Sang <wsa@the-dreams.de>

On 2017/05/29 at 16:42, Ulf Hansson wrote:
> On 29 May 2017 at 10:07, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 03/05/17 13:05, Benoît Thébaudeau wrote:
>>> The SDHCI_QUIRK_NO_MULTIBLOCK quirk was used as a workaround for the
>>> ENGcm07207 erratum. However, it caused excruciatingly slow SD transfers
>>> (300 kB/s on average), and this erratum actually does not imply that
>>> multiple-block transfers are not supported, so this was overkill.
>>>
>>> The suggested workaround for this erratum is to set SYSCTL.RSTA, but the
>>> simple DAT line software reset (which resets the DMA circuit among
>>> others) triggered by sdhci_finish_data() in case of errors seems to be
>>> sufficient. Indeed, generating errors in a controlled manner on i.MX25
>>> using the FEVT register right in the middle of read data transfers
>>> without this quirk shows that nothing is written to the buffer by the
>>> eSDHC past CMD12, and no extra Auto CMD12 is sent with AC12EN set, so
>>> the data transfers on AHB are properly aborted. For write data
>>> transfers, neither extra data nor extra Auto CMD12 is sent, as expected.
>>> Moreover, after intensive stress tests on i.MX25, removing
>>> SDHCI_QUIRK_NO_MULTIBLOCK seems to be safe.
>>>
>>> Signed-off-by: Benoît Thébaudeau <benoit@wsystem.com>
>>
>> Aside from one comment below...
>>
>> I would expect to see Acks from other sdhci-esdhc-imx users.  Nevertheless,
>> for sdhci:
> 
> Yes, I would also appreciate some ack/tested by, from the
> corresponding sdhci variant users of this series.
> 
> However, to allow it to get some results from linux-next, I have
> queued up this series for next (amending $subject patch according to
> the comment from Adrian). Thanks!

Please note that I had superseded this series with a v2 following Adrian's
comment.

>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>>
> 
> [...]

Best regards,
Benoît
