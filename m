Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B411C5519F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 08:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF7B2145D
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 08:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="mbpmT8c8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgKYIZ2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Nov 2020 03:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgKYIZ1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2020 03:25:27 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E33DC0613D4;
        Wed, 25 Nov 2020 00:25:27 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2C6EA22FEC;
        Wed, 25 Nov 2020 09:25:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606292725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Vw+CB+w0hZnW+Z0d6VuYsY62Nhe/QccAUo2NhvAyzQ=;
        b=mbpmT8c8kDrVEZ6ZJYJTwO+6+zgi7uzkoTsRmGRWXwMux9vTHMPf0u7yKhnAn9Y+0hzVq4
        AIVnjsaxaSe8LJMEQiL1RnuzBM8kv27MSO+8yF6b4IjlwRJcfG+CPDyJ6rwOGIXJjRD239
        Yq6P4tToHpDAPdL0/ddqH+dRxy5q18A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Nov 2020 09:25:23 +0100
From:   Michael Walle <michael@walle.cc>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
In-Reply-To: <AM7PR04MB688524B26F99EB2C5B86ED48F8FA0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
 <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201120093015.duel3yx63cbya77w@skbuf>
 <VI1PR04MB6896C22F6B304F365C3BA626F8FB0@VI1PR04MB6896.eurprd04.prod.outlook.com>
 <71a86b0fbc95892f8fd240e0919e7e23@walle.cc>
 <AM7PR04MB6885CA8A965A49C456454254F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <3293d698bf26ecf08f22e7e2ffe55e74@walle.cc>
 <AM7PR04MB688518B8AE836C2CC37FED6AF8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201124103128.zucizod344dgme4o@skbuf>
 <AM7PR04MB688567CA698191E2DB73DEF5F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201124112822.2ui57jmoc73top35@skbuf>
 <AM7PR04MB688524B26F99EB2C5B86ED48F8FA0@AM7PR04MB6885.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <31db48954bdf02fc0af73871043fc76b@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Yangbo, Hi Shawn,

Am 2020-11-25 03:59, schrieb Y.b. Lu:
>> -----Original Message-----
>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>> Sent: Tuesday, November 24, 2020 7:28 PM
>> To: Y.b. Lu <yangbo.lu@nxp.com>
>> Cc: Michael Walle <michael@walle.cc>; Shawn Guo <shawnguo@kernel.org>;
>> Leo Li <leoyang.li@nxp.com>; Rob Herring <robh+dt@kernel.org>;
>> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; 
>> Adrian
>> Hunter <adrian.hunter@intel.com>; Ulf Hansson 
>> <ulf.hansson@linaro.org>;
>> linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Ashish Kumar
>> <ashish.kumar@nxp.com>
>> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
>> controllers use fixed indices
>> 
>> On Tue, Nov 24, 2020 at 11:15:19AM +0000, Y.b. Lu wrote:
>> > > > Not matter it's SD card or eMMC card, if it's on esdhc0, use
>> /dev/mmcblk0.
>> > > > Not matter it's SD card or eMMC card, if it's on esdhc1, use
>> /dev/mmcblk1.
>> > >
>> > > With the note here that you can't actually connect an SD card to eSDHC1,
>> > > due to the lack of pins for CD/WP.
>> >
>> > CD/WP is not essential to support SD card. Both SD/eMMC are supported on
>> both eSDHC controllers.
>> 
>> Let's keep that discussion separate. While in theory you might be 
>> right,
>> I think the real-life complications associated with connecting an eMMC
>> to eSDHC0 and an SD card to eSDHC1 will make everyone avoid that. So 
>> in
>> practice they are still single-purpose.
> 
> You may refer to Layerscape QDS boards. 5 types SDHC adapters with
> PCIe connecter supporting SD or eMMC could be used on each esdhc
> interface.

Just for completeness, on the LS1028A there is definetly one for eMMC
and one for SD card. One supports voltage switching and one has a 8bit
data bus. But as Vladimir already said, this doesn't matter for this
discussion.

> Another reason using default mmc0 for esdhc0 and mmc1 for esdhc1, is
> because that's also the order before esdhc driver introducing
> asynchronous probe.

No if there was
   &esdhc { status = "disabled" };
this would change the block device from /dev/mmcblk0 to /dev/mmcblk1
for the remaining &esdhc1.

We are going cirlces here. I guess Shawn (as the soc maintainer) has to
step in and decide if a common soc include should contain aliases for
nodes which are disabled. That is what it boils down to.

All other arguments against having aliases in the common include can be
found in this thread.

> Distros, bootloaders, and users' cases using fixed index before could
> avoid issues, and been used as they were.

Nobody argue against having these alias. We are arguing against having
them in the common soc include.

-michael
