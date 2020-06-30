Return-Path: <SRS0=kdqm=AL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC68AC433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Jun 2020 19:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDA9206B6
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Jun 2020 19:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="oXqzXabP";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="K9yP762Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgF3Too (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:44:44 -0400
Received: from node.akkea.ca ([192.155.83.177]:40240 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgF3Ton (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 30 Jun 2020 15:44:43 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2020 15:44:43 EDT
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 6E97D4E2010;
        Tue, 30 Jun 2020 19:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1593545959; bh=EkcQ25+Mt2Tih27hW4FSnDfq/lrOC1qS5QPPk0jN0RI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=oXqzXabPNu5tfRfNvDzMx3P6gyrD/WH2c4M8FT/7l96Uzefxp6pLIWmYGKVnbaI4c
         fK5OSgaXR0Hjav/URAg+6rsq72Npf7Y1WTBbD/gi2I50OWf7vA5AMZUR/1vE8vy19L
         Q1eWC4f6CI4TnzWYpwJ5kQNLvGph3jb7bPRIch1k=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wv7EI1JpjBbd; Tue, 30 Jun 2020 19:39:18 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id B0A064E200E;
        Tue, 30 Jun 2020 19:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1593545958; bh=EkcQ25+Mt2Tih27hW4FSnDfq/lrOC1qS5QPPk0jN0RI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=K9yP762YvWUD1pNswyEPPVQVKwB3B7TIt98vZVSUwXGbz0gy4LWjZ5cqLt1PsKO8+
         HTShCW/+/8goSTgEzr6kbDO9o42tmlU7AyiMDYJWb5FOvysCOsRyFw0JQbHIdFof3r
         K/oMeGcFI4W7EtAjHnDmsk5J+BWUSaGRNJt9ENpE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Jun 2020 12:39:18 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     BOUGH CHEN <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: sdhci timeout on imx8mq
In-Reply-To: <CAOMZO5CkSSidzLUSBUvJNAio3SnmU-fisTbDCiLN9v1EjS+HHQ@mail.gmail.com>
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
 <20200205092653.GB2737@bogon.m.sigxcpu.org>
 <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
 <VI1PR04MB5040A046E5D93265AE636B29901C0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <VI1PR04MB504091C7991353F6092A8D91901A0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <CAOMZO5CkSSidzLUSBUvJNAio3SnmU-fisTbDCiLN9v1EjS+HHQ@mail.gmail.com>
Message-ID: <5ad361195f2e191484c8a231be0f5a07@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Fabio, Bough

On 2020-02-13 02:53, Fabio Estevam wrote:
> Hi Bough,
> 
> On Wed, Feb 12, 2020 at 11:33 PM BOUGH CHEN <haibo.chen@nxp.com> wrote:
> 
>> The board I use is SCH-29615 REV B4.  This board use Sandisk eMMC 
>> chip. Maybe your board use Micron eMMC.
> 
> Mine is REV B3 with the Micron eMMC.
> 
>> I attach the bootloader I use. Please try this bootloader on your 
>> side.
> 
> I hope we don't have a bootloader dependency here.
> 

Has there been any progress with this. I'm getting this on about 50% of 
boots with 5.7.5 in some configurations. I'm working on the USB 
subsystem so nothing that should directly influence the sdhci code.

Our device tree setup for the usdhc is the same as the imx8mq-evk

https://source.puri.sm/Librem5/linux-next/-/blob/imx8-current-librem5/arch/arm64/boot/dts/freescale/imx8mq-librem5.dts#L836

Thanks
Angus

> Thanks
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
