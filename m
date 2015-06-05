From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: esdhc: add quirk to support 3.3v for T4240
Date: Fri, 5 Jun 2015 10:19:14 +0200
Message-ID: <CAPDyKFqFqwjbP6=wbLtf35B31ou4npxYkQTcCDWAt8TnHVND7w@mail.gmail.com>
References: <1433228991-24324-1-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFp7=2L2_Vt1ha3jcFV=P2EDHEg0UwpcRu_t8r+ED-jDdA@mail.gmail.com>
	<BY1PR0301MB1192D4F50E8155073F771DC5F2B30@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<CAPDyKFoo+iejT2S8EQ2hgVQxd3Bj7geYPE_JqHkZ5WK0xKmxxA@mail.gmail.com>
	<BN3PR0301MB11880D7C297EE4636D9E721CF2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
	<CAPDyKFqHmspn5E_TN8A8FxGWu=em4X++K-7Xrp+GzZSk=NPfkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:36185 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbFEITP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2015 04:19:15 -0400
Received: by qcxw10 with SMTP id w10so27348436qcx.3
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jun 2015 01:19:14 -0700 (PDT)
In-Reply-To: <CAPDyKFqHmspn5E_TN8A8FxGWu=em4X++K-7Xrp+GzZSk=NPfkQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Lu Y.B." <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

[...]

>> But the "&" operation will make host->ocr_mask to have no use for other voltage supporting.
>> I think using "|" instead or just assigning host->ocr_mask to ocr_avail should be ok.
>> If so, there is no need to add this quirk.
>
> This is kind of a policy change for how to treat the configuration
> from DT. I have cc:ed Haijun Zhang, which invented the binding to see
> if we can get some feeback from him.
>
> The commit is: 6e9e318b304fd7373a0754805a76a02ddbc69a41 ("mmc: core:
> parse voltage from device-tree")
>

The email of Haijun Zhang, bounced so I guess we shouldn't expect any
response from him.

Kind regards
Uffe
