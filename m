Return-Path: <SRS0=ssCU=6L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2EFC54FD0
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 05:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1632084D
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 05:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UG9GoECH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgD0Fyq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Apr 2020 01:54:46 -0400
Received: from mout.web.de ([217.72.192.78]:42561 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgD0Fyp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Apr 2020 01:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587966881;
        bh=CvEdOia6fAvSdHnGMSMI5Rtcn6D+/Gq6x+rN574MCbU=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=UG9GoECHVXekacVQKiiLjLOyzmhmIvOJDHRCeMl8oc81YbruPNX2Lyg46LiDw8TnU
         EM4KbyHF8zgcoXTxtJbzbsh9qPMLh6bYkAY/tGBCRmRxJuKLMe21OemHaeJ1PDnRHE
         EINtHCF8/ljCOzY1sF2+gKcAYkGbmZEk7EfSHm0E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.190.48]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MT8bi-1jZzkN06gY-00S81W; Mon, 27
 Apr 2020 07:54:41 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Drake <drake@endlessm.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: alcor: Fix a resource leak in an error handling path
 in 'alcor_pci_sdmmc_drv_probe()'
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org
Message-ID: <35c7cffb-02dd-452c-f525-fe5ddcbb0a48@web.de>
Date:   Mon, 27 Apr 2020 07:54:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OwOxnVlqSwFUD0FvkQf23q2xhV9b2OY6hjmBgLudJkhqOpY2TJn
 phCU3uWY1jjkDyrWAtwbYep2w6Jryr7O4s5FYbgTRdFbopBpS/RCwQPDBZDHLAYQLZiL/7c
 84CVcmRUhxSQujGqCt5a2Q8ljaEh4owaATlTdb22gKWWSqdTaMCW5AY5ThjKhXmSjLxCuR7
 Llc5okHUg4qDNI6c8hDxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kTAeSn7YrU0=:rLX/+45AN6lznfAavQS9J9
 hk0hgogryjhtDZ/yxoTMEzCwGf6bzv/tNPNV+pNyaCpaj29P+jIpy6g2JrOe59Fe7Y1I55ZMe
 T/rRUTXUOnB5tBmDg74BmvKKNahmMTPb6V1hbVMoiCHnoGwSNBBR42dnBKQR28FkgO8QISRbV
 tbFYteOIvfKjbHr7k9e4rSAspwHOG9HsxsEFxQdqFmdnr3OBXzkSpVbdelXxqrc7VD0F7gRRq
 1/og4NZmohO+fa4mmMsinikB9G4MRAK+S5zw7T5jwtUl+W92jSYzWW0LjqtY3f26f3R97gPri
 XAMaAmXTNd2k4MAmfmvgkcn85cMZISn1RUb9H8jTYpc8Tz+QBjbIRwk3x0yL4RHNrn5QZBACC
 MyXOh5f8ooeUsBcOi1juVwFDYjqpxZKEwcqhsfx0rBQnvtp8lvFwCjkDvy2qsvi2gCFe+HvUb
 qnRisqBJKrt7ux8WfdpkLEUC6GFoOdelIfj1tAdjq8qScpo0NZ+vifhI3jZmOPi5zfO/JMWiR
 LDxEEtyXveFjm6huiF3uNMDvkCpkLeueE5Ogs5MLNuEEWxqZlUdQoHQMiM2fmS4t186oqAsEI
 7LXrfnlqWDdIjLMXLYrfy+O9JUjp5k4/IPnmuB4cuOBT8P2uE4nhjqk/K9z7TaIK72vHwrumN
 YlH6MPcM9rjNUVQSMYPGcdK4H/9LLhnM3M3UIf6ajmthq/mrwuTQOuhjqePpA7eEs3CvERG0b
 qAuJLRVlTzSoY81SLvHjbnAbVvo57VxbjZAu+Te3u8AavA56qp5mSaxutBSC+cUFZ1mqyFIjO
 +a/FW8B/XM8gezmrQCaENcmk/Y/w9bVg01bmyJ1UZPGutvuz+Yk3HAv68JCdMbLDCqZad9az6
 sGalgl/4SdVVuGngVESjL5qF9oTCXEYjmrAjTfEYgl5kL1iuiYTJZi5tohqXbSV3tE/QNR1eX
 SilNGjZjBvvroaW5NGujNCT9HWX506nQrXP0MTrD3pLo+eo40rRKD3ScdmUO3BpUAeDxzdTWW
 RQ9X8tWRzv/7Ft0saFzJJs1NQmYGMXORcAIspBX+IxbEfNMP+B2gVv+xEYOTTUMoO+MD70ekR
 V1n0wR2jBlundGr6TIbsRAhNYjLy0qGjQpCS181jpwPjZom2E+MvcZkUHW7c3eE0cROUMnuvY
 fnm4p8ntmAFWTwTuxT0XMAP8qNpvixzHYbTOwchel1k2F12tKvXZXIRR0HMHf0m2KjfstIH9a
 +8WtQfTMNe+v9qNS6
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> If 'devm_request_threaded_irq()' fails, resources allocated by
> 'mmc_alloc_host()' must be freed.

How do you think about a wording variant like the following?

   Subject:
   [PATCH v2] mmc: alcor: Complete exception handling in alcor_pci_sdmmc_d=
rv_probe()

   Change description (according to a solution alternative):
   The exception handling was incomplete in an if branch
   after a failed call of the function =E2=80=9Cdevm_request_threaded_irq=
=E2=80=9D.
   Thus add a call of the function =E2=80=9Cmmc_free_host=E2=80=9D for the=
 release of
   corresponding system resources.


> +++ b/drivers/mmc/host/alcor.c
> @@ -1104,7 +1104,7 @@ static int alcor_pci_sdmmc_drv_probe(struct platfo=
rm_device *pdev)
>
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to get irq for data line\n");
> -		return ret;
> +		goto free_host;
>  	}
>
>  	mutex_init(&host->cmd_mutex);

You propose to perform a jump to other code only once in this implementati=
on.
I find it more succinct to call the desired function then directly.

 		dev_err(=E2=80=A6);
+		mmc_free_host(mmc);
 		return ret;


Regards,
Markus
