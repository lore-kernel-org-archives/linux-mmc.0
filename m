Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3621BC2B9F7
	for <linux-mmc@archiver.kernel.org>; Wed, 26 May 2021 07:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0745E610A0
	for <linux-mmc@archiver.kernel.org>; Wed, 26 May 2021 07:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhEZHsI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 May 2021 03:48:08 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:45840 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbhEZHsI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 May 2021 03:48:08 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d47 with ME
        id 9KmY2500h21Fzsu03KmZ7X; Wed, 26 May 2021 09:46:35 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 26 May 2021 09:46:35 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH] mmc: mxs-mmc: Disable the 'reg_vmmc' regulator when
 needed
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Doug Anderson <dianders@chromium.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Chris Ball <cjb@laptop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <d05074c11962a046ff9c2f457c240432ca8a7194.1621600443.git.christophe.jaillet@wanadoo.fr>
 <CAPDyKFrS3wdYs3AQtjZEOsLzNvxgy1n3EfxZ+a8w8J8rH8kQ-w@mail.gmail.com>
 <7c973bfd-8fc3-026d-351c-dc00e92c8b01@wanadoo.fr>
 <CAPDyKFptO4PRc=kxd9k8CkofGfyfJB6pdxP-wzrNpSHv0+ya0Q@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <fa7e957e-4b3d-6ff6-1f72-e630eda2960d@wanadoo.fr>
Date:   Wed, 26 May 2021 09:46:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFptO4PRc=kxd9k8CkofGfyfJB6pdxP-wzrNpSHv0+ya0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Le 26/05/2021 à 00:47, Ulf Hansson a écrit :
> If I put together some patch and submit it, would you be able help to
> run some tests of it, as I don't have access to HW?

No, I won't be able to help.
This only got triggered by a static analysis checker (a own made 
coccinelle script) and I don't have the hardware to test anything.

This is why I can't propose an updated proposal. Trial & error 
development when you can't test by yourself is only counterproductive.

CJ

> 
> Kind regards
> Uffe
> 

