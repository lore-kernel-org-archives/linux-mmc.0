Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F61FC4361B
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 20:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A20D23B6C
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 20:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgLRUw7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Dec 2020 15:52:59 -0500
Received: from node.akkea.ca ([192.155.83.177]:60324 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgLRUw7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 18 Dec 2020 15:52:59 -0500
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Dec 2020 15:52:59 EST
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id F1E194E6562;
        Fri, 18 Dec 2020 20:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1608324330; bh=WejVtnCVkdeP6cDq74BjfNEvVaPnFPD/qvuyqoneZ7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=QyqfV//OV8teMzPd1evgPoAx+qln9nmPYh0YvmOFdcaBlyXg4DlHA/84J6sb280rA
         hV0V29vb6nFu0/zknNaupQCV6BJcREzPFPmgMSMud2mDNedA3rnE/PqSssmz5ezGtC
         HbJ5jKVUckwTTUAjoUOwh7eFZj/PlggBqwRzBXcg=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c5lwaYtbGhqB; Fri, 18 Dec 2020 20:45:28 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id AFBD74E655D;
        Fri, 18 Dec 2020 20:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1608324328; bh=WejVtnCVkdeP6cDq74BjfNEvVaPnFPD/qvuyqoneZ7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=w4HhWqrYngUcJFcjAv35NdpV8AhlPoXaIpHKfKj6PG62zrAOF9VCoW1821O0sb6qB
         KQ3QDQ8IaLmFRoPDHtk3nExoU6bGDHBiqsMW+Cs6+ESgZ7rBy2GzuPvuCPM0/+V2wc
         ZTGkDhEXFgwy5fK/AHQjDQQ5PpcnQuVgqJtsmcec=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 18 Dec 2020 12:45:28 -0800
From:   Angus Ainslie <angus@akkea.ca>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     BOUGH CHEN <haibo.chen@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: sdhci timeout on imx8mq
In-Reply-To: <4a1fb9fa69d6fdb0ec2d7c390112d412d512ff13.camel@pengutronix.de>
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
 <20200205092653.GB2737@bogon.m.sigxcpu.org>
 <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
 <VI1PR04MB5040A046E5D93265AE636B29901C0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <VI1PR04MB504091C7991353F6092A8D91901A0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <CAOMZO5CkSSidzLUSBUvJNAio3SnmU-fisTbDCiLN9v1EjS+HHQ@mail.gmail.com>
 <5ad361195f2e191484c8a231be0f5a07@akkea.ca>
 <CAOMZO5BarV1=6rx9L_hkJJLUQSicwPNUO4HFKWAXSQ6n0N+Kzg@mail.gmail.com>
 <VI1PR04MB52942233A0BA6BCB692F281E90670@VI1PR04MB5294.eurprd04.prod.outlook.com>
 <4a1fb9fa69d6fdb0ec2d7c390112d412d512ff13.camel@pengutronix.de>
Message-ID: <f0255cf8701d823b862074a2e755cbe8@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Lucas,

Thanks for the ping, I've been meaning to get back to this.

On 2020-12-18 12:07, Lucas Stach wrote:
> Hi all,
> 
> Am Mittwoch, dem 08.07.2020 um 01:32 +0000 schrieb BOUGH CHEN:
>> -----Original Message-----
>> From: Fabio Estevam [mailto:festevam@gmail.com]
>> Sent: 2020年7月7日 20:45
>> To: Angus Ainslie <angus@akkea.ca>
>> Cc: BOUGH CHEN <haibo.chen@nxp.com>; Ulf Hansson
>> <ulf.hansson@linaro.org>; Guido Günther <agx@sigxcpu.org>; linux-mmc
>> <linux-mmc@vger.kernel.org>; Adrian Hunter <adrian.hunter@intel.com>;
>> dl-linux-imx <linux-imx@nxp.com>; Sascha Hauer
>> <kernel@pengutronix.de>;
>> moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
>> <linux-arm-kernel@lists.infradead.org>
>> Subject: Re: sdhci timeout on imx8mq
>> 
>> Hi Angus,
>> 
>> On Tue, Jun 30, 2020 at 4:39 PM Angus Ainslie <angus@akkea.ca> wrote:
>> 
>> > Has there been any progress with this. I'm getting this on about
>> > 50%
>> > of
>> 
>> Not from my side, sorry.
>> 
>> Bough,
>> 
>> Do you know why this problem affects the imx8mq-evk versions that are
>> populated with the Micron eMMC and not the ones with Sandisk eMMC?
> 
> Hi Angus,
> 
> Can you show me the full fail log? I do not meet this issue on my side,
> besides, which kind of uboot do you use?

I have not seen this on any of my devices running 5.9.x but I think 
there have been reports of this still failing so I'll try and find out 
whether it's with the 5.9.x kernel or newer.

We're using a modified imx u-boot

https://source.puri.sm/Librem5/uboot-imx/

> 
> Has there been any progress on this issue? I'm now hitting this on a
> system that just upgraded from 5.4 to 5.10. Has anyone tried bisecting
> this issue, yet?

We have other issues with 5.10 right now so it hasn't had much testing.

Angus

> 
> Regards,
> Lucas
