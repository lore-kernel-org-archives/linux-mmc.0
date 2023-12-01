Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="iGyUHwET"
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C4A19A6
	for <linux-mmc@vger.kernel.org>; Fri,  1 Dec 2023 01:39:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b479ec4a3so16949255e9.2
        for <linux-mmc@vger.kernel.org>; Fri, 01 Dec 2023 01:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701423543; x=1702028343; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jC3/MuCtGjepod8Zkfcj95KcJ99A6m3gq/BQ2t/6ZL4=;
        b=iGyUHwETdWNYzY8Zfu300PY2PStD5FxNBr5dz/jjSUPRMRfDpONJiQp5/pKf/P4Glg
         4mWd8mcwZcZxajpqhnMOOjXc0YsMw3/tARKVBc38sDKkvX7DiE287rDs8hOZdcuaQ60R
         LlRqxzvz3LsbZGULZyreqYKthB+4SMCUktfFxLGRoBcNet5m/EyTveYfOrUxjPHkIdZH
         BKuJCFkZfVphA9crns/Xz0nqPk3RcPgmq8ir1N5SwWi7BdUIeJAocQFEc9rXnW/aLJid
         ITwzWg/M63zxN3DGqNcHCeB+HmeH5CVMXGnzCKJ2fPWuM8431j91c40BRWscmUUWykes
         SFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701423543; x=1702028343;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jC3/MuCtGjepod8Zkfcj95KcJ99A6m3gq/BQ2t/6ZL4=;
        b=gFqZ3DPrmkIpHQtn/LryUcayN3pZ5e/umgwpiq8P/1sIY+RImbZpsHX2LZh7F5q/wD
         iPChW+4NwTNp5Wb7TH6ueIxRMaFGVxtMVdNHhQdibOWzHyzqh1R0KYtlj3dDvd4Kc2bJ
         lYTuTNw8MrXl2dz8ma5R712RCQqwTAxPFxU2AgZN1OeN82EAm9FbgQ5Xl+5HGqMue69c
         OPanqbMVYQS2ozob9ZrjxtUSwgqYNBUtc3JvJ0lzjaUMQ5Bp+l6LL8uhvIu8Dbby4rZ7
         RemQj8vHY3hx2BLWqub+h4YIVFgJucCF+8HR+T+muTAdHCvaqiEqsUOlt9Qtwqo6zFv6
         TkRg==
X-Gm-Message-State: AOJu0YzCL6pO9swQE9GhZW/ZCcGjnPXX7gvf6S47xdaXGhleSBpVXYPZ
	E60Nl81QxIKm94ctYtDQKavf5A==
X-Google-Smtp-Source: AGHT+IGGFG211CMQAO0FD6H20iz2R22iotO1esAB+JYQVA/jB2mqxb3nBclo8HnFNxnodjtaPjDieg==
X-Received: by 2002:a7b:cc82:0:b0:40b:5e22:97f with SMTP id p2-20020a7bcc82000000b0040b5e22097fmr369829wma.110.1701423543053;
        Fri, 01 Dec 2023 01:39:03 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id bd22-20020a05600c1f1600b004090798d29csm4877947wmb.15.2023.12.01.01.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:39:02 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Fri, 1 Dec 2023 10:39:01 +0100
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge@foundries.io>, ulf.hansson@linaro.org,
	CLoehle@hyperstone.com, adrian.hunter@intel.com,
	jinpu.wang@ionos.com, hare@suse.de, beanhuo@micron.com,
	asuk4.q@gmail.com, yangyingliang@huawei.com, yibin.ding@unisoc.com,
	victor.shih@genesyslogic.com.tw, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: rpmb: fixes pause retune on all RPMB partitions.
Message-ID: <ZWmptatt60if9GBH@trax>
References: <20231201091034.936441-1-jorge@foundries.io>
 <CACRpkdaMnphBxvqpmvNG_72O02Umny3qdxfyrKdA4BsDwZmtfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaMnphBxvqpmvNG_72O02Umny3qdxfyrKdA4BsDwZmtfg@mail.gmail.com>

On 01/12/23 10:28:52, Linus Walleij wrote:
> Hi Jorge,
>
> thanks for your patch!
>
> On Fri, Dec 1, 2023 at 10:10 AM Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
>
> > When RPMB was converted to a character device, it added support for
> > multiple RPMB partitions (Commit 97548575bef3 ("mmc: block: Convert RPMB
> > to a character device").
> >
> > One of the changes in this commit was transforming the variable
> > target_part defined in __mmc_blk_ioctl_cmd into a bitmask.
> >
> > This inadvertedly regressed the validation check done in
> > mmc_blk_part_switch_pre() and mmc_blk_part_switch_post().
> >
> > This commit fixes that regression.
> >
> > Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
>
> My bug :/
> Shouldn't we also add Cc: stable@vger.kernel.org?

ack, will do.

>
>
> > +       const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
> >         int ret = 0;
> >
> > -       if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
> > +       if (part_type & mask == mask) {
>
> That looks complex, can't we just:
>
> if (part_type & EXT_CSD_PART_CONFIG_ACC_RPMB)?

I chose to mention the mask nature of the field for clarity - just in
case - but I'd much rather do your suggestion. So will do :)

>
> > +       const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
> >         int ret = 0;
> >
> > -       if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
> > +       if (part_type & mask == mask) {
>
> Dito here.

yep

>
> Yours,
> Linus Walleij

thanks !
