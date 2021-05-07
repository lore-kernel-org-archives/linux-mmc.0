Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3479CC433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 07:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0A0613D6
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 07:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhEGHIn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 May 2021 03:08:43 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:48531 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233730AbhEGHIm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2021 03:08:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id EDB0F58124E;
        Fri,  7 May 2021 03:07:42 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Fri, 07 May 2021 03:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=q+VAC568GzCcDMwNCnFEDtF1412nCnb
        auFVwJbsbwuM=; b=WXyJPMT4ZWdAIyCkoeAsXwq6dmXIAnL5Lagij8d9NaJasTp
        gMEmdzxHWb5kxAsNbRM9HZfddh6ttG/sYDs25cvmWO/DXtPFO71WpRWV4+TKnSyK
        8prGrbS6mOX2+RGbXZLRGcY1W5IvZrvBvVJqgSSWqAGz+EkMVQHmkjDuWejNUAeI
        S6zaf4Eul7CQReOrFj8pH8og2xJ94egkn/O8UlP7YgnYiPZypwUgGjZrPa44F2kI
        A2yRR1/ZyI6bAeWbNiwlg+DpD71rUWY1eBgBwFSN59Mib/gtqRBlw9Jra5e+jJOz
        AE/o3AOF1t4f/8Zd7ga/cFPJX8sBenpmOpV/alg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=q+VAC5
        68GzCcDMwNCnFEDtF1412nCnbauFVwJbsbwuM=; b=cl9pdSrnMTdDTAhtRs2BaO
        N9iFPUJjIFO6QorSloXzuKZjTCF0hRy5y107XXN6gOTYanFVn17535Wmeh5nquEJ
        jnfO5P9I7Xm/IrDMmscjRNCMYL4n00cHPbjtF7OrT7S9vN3zERiVAQtAreYOtShC
        7l+PXGTBbBe+ZaRBs3Fo+ge+UUgoA9YsUsglS0X+/LoiXPFm87j4AwGoAZi8NjK1
        6LNY82X9i9dH8j3oEbmIVFB8gggDUuYSSN7EU2QvDOW4pgryfGe8+I13LrR1gTHo
        VAIhHB8/yhOlZ+RVR/Aqw/1i8jYbEPceUmBpX2TX2mFAxE5rScClOqKlEUGDFftA
        ==
X-ME-Sender: <xms:POeUYFPapsp60JK4ld9l76Q52_r5FtzkegSOpGSteWeHzuVqhodTfg>
    <xme:POeUYH-jq7cZbWm0b-wWC0WiwvHRg4-KSoT_7OdSF5Zn9JgeZnuFOsRvXC6wRqNTz
    6DwxbeGkw7LkfcyNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeguddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpedutddtkeeugeegvddttdeukeeiuddtgfeuuddtfeeiueetfeeileet
    tedvtdfhieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:POeUYEQPbTt891MALMQcYNL3pwsR7mMmfv4MKkhIwfbgGY22uK10xQ>
    <xmx:POeUYBsEupgfUrDCQoIlYbStqtchVo1wFEpcHZxDeQcBikgoqdrb0Q>
    <xmx:POeUYNfFC5bh8udiKYhNCDCWZxX0CdMdKSBq0zGJg46uRIka1_SHRA>
    <xmx:PueUYA_TEcYpIFl85kGI-8qemAGULjMUmk-0ps8PDAmplNLkx0Kkxw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D246BA00079; Fri,  7 May 2021 03:07:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <e895e05b-fdcc-4192-befe-500c386ac64a@www.fastmail.com>
In-Reply-To: <20210507065918.GE23749@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-5-steven_lee@aspeedtech.com>
 <fecc9021-ab4b-4047-a664-47b1bd867cb3@www.fastmail.com>
 <20210507065918.GE23749@aspeedtech.com>
Date:   Fri, 07 May 2021 16:37:19 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Steven Lee" <steven_lee@aspeedtech.com>
Cc:     "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Ryan Chen" <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Hongwei Zhang" <Hongweiz@ami.com>,
        "Ryan Chen" <ryan_chen@aspeedtech.com>,
        "Chin-Ting Kuo" <chin-ting_kuo@aspeedtech.com>
Subject: =?UTF-8?Q?Re:_[PATCH_v3_4/5]_mmc:_sdhci-of-aspeed:_Add_a_helper_for_upda?=
 =?UTF-8?Q?ting_capability_register.?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Fri, 7 May 2021, at 16:29, Steven Lee wrote:
> The 05/07/2021 10:13, Andrew Jeffery wrote:
> > > +/*
> > > + * The function sets the mirror register for updating
> > > + * capbilities of the current slot.
> > > + *
> > > + *   slot | capability  | caps_reg | mirror_reg
> > > + *   -----|-------------|----------|------------
> > > + *     0  | CAP1_1_8V   | SDIO140  |   SDIO10
> > > + *     0  | CAP2_SDR104 | SDIO144  |   SDIO14
> > > + *     1  | CAP1_1_8V   | SDIO240  |   SDIO20
> > > + *     1  | CAP2_SDR104 | SDIO244  |   SDIO24
> > 
> > It would be nice to align the columns to improve readability.
> > 
> 
> Columns seems are aligned in my mail client(mutt) and my editor(vim).
> I paste the above comment in Notepad++, columns are aligned as well.
> 

Ah, it's probably my mail client then. Sorry for the noise!

Andrew
