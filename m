Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4F0C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 00:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45F960FDA
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 00:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbhKHAYy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 7 Nov 2021 19:24:54 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:34063 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234291AbhKHAYy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Nov 2021 19:24:54 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 08DD95803EE;
        Sun,  7 Nov 2021 19:22:10 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute4.internal (MEProxy); Sun, 07 Nov 2021 19:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=G+UTj3AnYA8ZP4iI6M9Sj8AQF+R2TPP
        HefdgO8p+64c=; b=DH5pY0FSsMwGpnEmhsJQjDs5+cmjOwQWLhAQvbBGLs0a0cv
        mvH/jrNMkqIBGr63FcxWAukxOx7Y1xbd9WVbJMSTmRiE/jtJQrHUKFdy6F5Z5oLp
        EYnVAlFpySFfCFHWOr1EvvSYap8eiM1WalaF9SOJ+41uxPG7ZCCNhSNbwnXc4SOX
        YZbOw4fCuxEulH6S5TugJUP6T3rdbd/PNgF5C0IWPmiYh+O3DTiqH1+N4MdJfmlU
        vUBRyjGmC284GFHpWuewHG0BpEV+dCgndjYgwv0DlLqWML/lpxGVWTApmkYTI/GH
        czRsGFmdIa7KkHqion/z3vE2qaAU4LHjngwdOeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=G+UTj3
        AnYA8ZP4iI6M9Sj8AQF+R2TPPHefdgO8p+64c=; b=a0M181+Us4nINoGWsTOddb
        Nr2mH2QxHIKkVlSS2+Ub0kKadvvT+Z8DhMtiZ10GBqDDhSKML8Kr2Uh8/SqGkYY9
        Q5dNHPksEGldk3TLhhAJM/BH1ma8Jmj87/WcfrzoqHT8dHRcDR0Z8d6S7u8/eixO
        4Ut7AaJwE7nr2kT0lYGX11ukx7ogp9zvs3+8b3tya3hcAKNO7hBxac4CcO1FqZKD
        PEiDikdX0z4Qdth70qXI6eszhy2jyZ7aJl/yi08W5SNjzA0xmx7rvok/5HGcDIfO
        ua6UJo3HCrF1QLCq93/wSyrlrGYS3INatr3oXrC2QwAOBjgxQHf4cv6cP9dIplEQ
        ==
X-ME-Sender: <xms:sG2IYfOmGMRwDRHEKw7G2X-Q1qTZoreJSkxOEU2qle1m5Vi8geFhfQ>
    <xme:sG2IYZ-Dd47EDJprU4ATIC6VUbN3VWPvf7wCV4cUVFknQqdGBgEJNQtaqJKj9AtOk
    -NPpLsrK9cd7i2XLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddugdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedvhefh
    veeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:sW2IYeQ8GDnxOnxEDbamLr9AinuScHhomTeRjEjypP8_XcwY1iWZBw>
    <xmx:sW2IYTsxGjXExSohLnFLfrx5MAKpVfOHQ_EdsJ1Nh0HW-ESE6g7ctg>
    <xmx:sW2IYXe8Ce1npBf6FZmtSjNgKSfMDKrln5v1luDUwXi2x0h0qPPOzw>
    <xmx:sm2IYS-6aQHVxKhqTQwWrUDokHYs79zxyrcrrQ4pGhIltI3Adu9u1Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E931FAC0DD1; Sun,  7 Nov 2021 19:22:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <c79e93c3-1678-412f-87c5-2b757d806574@www.fastmail.com>
In-Reply-To: <HK0PR06MB27861518CA84A9DC8D204AC1B28F9@HK0PR06MB2786.apcprd06.prod.outlook.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-5-chin-ting_kuo@aspeedtech.com>
 <5a235916-f250-48ac-b931-6ec2c5c2ea5d@www.fastmail.com>
 <HK0PR06MB27861518CA84A9DC8D204AC1B28F9@HK0PR06MB2786.apcprd06.prod.outlook.com>
Date:   Mon, 08 Nov 2021 10:51:48 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Chin-Ting Kuo" <chin-ting_kuo@aspeedtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     BMC-SW <BMC-SW@aspeedtech.com>,
        "Steven Lee" <steven_lee@aspeedtech.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 04/10] mmc: Add invert flag for clock phase signedness
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 6 Nov 2021, at 20:32, Chin-Ting Kuo wrote:
> Hi Andrew,
>>> > -	rc = device_property_read_u32_array(dev, prop, degrees, 2);
>> > +	rc = device_property_read_u32_array(dev, prop, degrees, 4);
>> >  	phase->valid = !rc;
>> >  	if (phase->valid) {
>> > -		phase->in_deg = degrees[0];
>> > -		phase->out_deg = degrees[1];
>> > +		phase->inv_in_deg = degrees[0] ? true : false;
>> > +		phase->in_deg = degrees[1];
>> > +		phase->inv_out_deg = degrees[2] ? true : false;
>> > +		phase->out_deg = degrees[3];
>> 
>> This fundamentally breaks any in-tree users. We can't do this.
>> 
>> In terms of the binding, if negative phase values are something we must do,
>> we can just extend the value range to include [-359, -1] right?
>
> Yes, agree it and I tried it before. But, it seems that the device tree 
> doesn't support
> negative value with "-" prefixed and there is no device tree related 
> API used to get
> the negative value from .dts. Thus, I tried to add an additional flag 
> to present
> negative value.
>

Hmm. Still, I don't think we can break the binding this way.

Rob, Ulf, Adrian: What are your thoughts on handling phase offsets in 
[-360, 360] in the binding? Do we append the flag field? Add a separate 
property? I don't think interleaving the flags is desirable, though 
interested in your thoughts.

Andrew
