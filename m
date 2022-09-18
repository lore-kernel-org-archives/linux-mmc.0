Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015CDC54EE9
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Sep 2022 14:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIROO3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Sep 2022 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiIROOY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Sep 2022 10:14:24 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159B124BCE
        for <linux-mmc@vger.kernel.org>; Sun, 18 Sep 2022 07:14:21 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 224C32B059AE;
        Sun, 18 Sep 2022 10:14:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sun, 18 Sep 2022 10:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663510458; x=1663514058; bh=pns1KUpAUu
        r5I/nJh1T2WlW+OC5sPFg5Yv1WiNKCYck=; b=USncfy4gVAmE7AkAfH3VgviRKx
        zb2KRswe9vgkJDTPRrG+S03xC1i+PCGWT882aZOO4jhj90UGJ6sU7nIdoadVydD/
        D+IM4eObT/Y0CbAnwSkrdzAsc1K25lhKXt5ouSsjgoqoaDBSIzwcWVN12kVdYEHa
        D7RDQjXMEH+hO/7hFBgjz5AQVLbWYfltr2vaxrad/4DWNfcLoGK3tihIMcyQg7oA
        HpvU4mEHJilaR8Z0vnR7iFuRcfUBv2VvTt1CFvOoi+g/WnlGwUCkLtQOYcRVuJIV
        3WrR8XlNJkUKl5cuCUBktzgc2OIEqVAAHooSZyFCmrGJ0QlBna9WIy2dnRxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663510458; x=1663514058; bh=pns1KUpAUur5I/nJh1T2WlW+OC5s
        PFg5Yv1WiNKCYck=; b=tn0SrOdaMo6A+JohCVyQqJWw/CDkm4PalUWZtmIeiqso
        g4sDM9NSB5qzguV3GZRPABNViyXIR/F+WvUF9Kcb9TI4qWTvlWi0I8HLhWSKF36/
        Ie6+LNpWmQBVIk6uARBtF+9iuyXxSRTO4wYmUIqoDWUclM1sX05b4hqflZ2V7upj
        R4olMK7+UEI3RLNICZuZ9OE91JcQrPkqRBengCXbme6t5/w1RdKsKUP7qZFAohr3
        AImFTXNUUCHpWb8ir7t4hcurm+eyxE2FqLTH62N0u1Em9wkexaVlxgmbYqZu5adv
        0KHiGMQ2IGIpZ1MkPXADRn6OjNAdjCdWe2oUhB7ELg==
X-ME-Sender: <xms:uicnY7k8Q0m9fUkOkg87lDfE01PiSwteTGWEBV-NPUqlnEAXgENx1Q>
    <xme:uicnY-0ssUoMhspkx-vBe2epTHDpXwQdZgYJIhucfk8ILVBC296LxExepTJVK7BTz
    F3zkp0Pfg8XLwj2cog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvhedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:uicnYxpnqePUU80jQGkXu9jIjsGfMi_2GaptaCY7x0KaSoZZDo93AA>
    <xmx:uicnYzmunf7aJO5JvpFEEScHXtoANoOQboV3p6uW7KRzpk5b-Pk3Gw>
    <xmx:uicnY50oelo5xljxEa8qO7HH6Fvdv3ExFfDSzqtTCWj4ISJexbRkbA>
    <xmx:uicnY2-N7sSBQYGRELzx7gn9IHcTnJTc47HnjnIV-3m0gltQRXtzlrhJOMk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 50974B60086; Sun, 18 Sep 2022 10:14:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <21dc5b78-c0e9-4664-83f9-1a6cbe76159f@www.fastmail.com>
In-Reply-To: <20220918124210.1127345-1-giulio.benetti@benettiengineering.com>
References: <DM6PR04MB657537960D8614C467F6708CFC4A9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <20220918124210.1127345-1-giulio.benetti@benettiengineering.com>
Date:   Sun, 18 Sep 2022 16:13:58 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Giulio Benetti" <giulio.benetti@benettiengineering.com>,
        "Avri Altman" <Avri.Altman@wdc.com>
Cc:     "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2] mmc-utils: mmc_cmds.c: fix warning on uninitialized 'cnt'
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Sep 18, 2022, at 2:42 PM, Giulio Benetti wrote:
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
> V1->V2:
> * prefix subjet with 'mmc-utils:' as pointed by Avri Altman
> ---
>  mmc_cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 12b7802..777d649 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2436,7 +2436,7 @@ int do_rpmb_write_block(int nargs, char **argv)
>  	int ret, dev_fd, key_fd, data_fd;
>  	unsigned char key[32];
>  	uint16_t addr;
> -	unsigned int cnt;
> +	unsigned int cnt = 0;
>  	struct rpmb_frame frame_in = {
>  		.req_resp    = htobe16(MMC_RPMB_WRITE),
>  		.block_count = htobe16(1)

I think this is the wrong place to initialize it, I would
suggest doing it inside of rpmb_read_counter() when returning
an error, to make it clear that this is not the intended
counter but something that is not actually meant to be used.

If you initialize local variables to bogus values, you remove
the possibility for the compiler to warn a function actually uses
something without initialization.

       Arnd
