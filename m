Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C55C46467
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 09:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjAPJGS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 04:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjAPJFv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 04:05:51 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE25215574;
        Mon, 16 Jan 2023 01:03:01 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r9so3970391wrw.4;
        Mon, 16 Jan 2023 01:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJkudWJwNygPc1saqVRch4BZHQ+ehuxSBNJGOWOBYEc=;
        b=b1eH9W1rAzmDTe8ul034A2j9Isfkso8B2RWgb0GkfspkFWMJyjT3Dwdx4TifCn/TBo
         6tUyzNuYsfZSH1+Ugv7TedGMmJkmdhKe92OYed/GHPJxx4F5fGTJ+W+KIfy9uwIfrKq/
         1sXhbKdZrvWTovCZItUWJ/uxb4oyX+3wXJmc5ZK443PXBQbUL+u/Il/cwXi6SW47hTWn
         sgzMugkdlM+jCtSg7BTKsLv3f9S7DszQN4094JDAnVpzc+/bRfwWTqKUglkFL7MwoP49
         MenIoySpwAS7NUsdYUUcAv/+X4veTQDxTWL6HroFryrYcHuAzwfpKPBBMVsFyj2jcssS
         5vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJkudWJwNygPc1saqVRch4BZHQ+ehuxSBNJGOWOBYEc=;
        b=n0OvGJaDjzQFUeuo9BQKXHCMPv0NzQ49iagfV3BE8ybvoAUwgslfIucpMMpITOOwg4
         Ln63I1dEzwVk0fNH1rYxkKL40kSk8ilnHCmwS563+bzDLo01UksFqsxX7VF1Jmew6b+o
         Tz2vJbsZQeHzKbK1DHqzies+ZX/Ux9mfcv/pe/ltJ1XLxocCNDDivbXrOVhtq5nxU3Py
         20vaj/ZHQNA/jlrEEBEquQnXoYaGyCCqxaYxMK3QzszMDab8aICfPCp0j0EoVXD/Ky5r
         rWobX6nVaLAsskLiDh2V4j+QaErB7eBukijTKBcZLIcMNEPx4GiRR8QVHMQcqAAVfXny
         p6hw==
X-Gm-Message-State: AFqh2krb2uaAF8f4C+uUT3uQrd9UVS3jUK93D2NDmDbYsrUv695/xxa9
        1/YEgQcTeRexNV/aUvYzjTY=
X-Google-Smtp-Source: AMrXdXubq8KNmFzoWrAIWnJh9Wd+mZEctZzMEnSPrLhLIiYlWwGuyXD7MHR5PoeAChfEU6c9+BXC0g==
X-Received: by 2002:adf:fbc1:0:b0:242:1415:ab02 with SMTP id d1-20020adffbc1000000b002421415ab02mr51331140wrs.9.1673859779817;
        Mon, 16 Jan 2023 01:02:59 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t13-20020adfe10d000000b002b6bcc0b64dsm13323050wrz.4.2023.01.16.01.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 01:02:59 -0800 (PST)
Date:   Mon, 16 Jan 2023 12:02:56 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Doug Brown <doug@schmorgal.com>
Cc:     oe-kbuild@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/8] mmc: sdhci-pxav2: add optional core clock
Message-ID: <Y8USwHNZfuaP1ro8@kadam>
References: <202301140445.zXxR25qN-lkp@intel.com>
 <b5867cb5-aeed-b081-543f-fd611c3c84c9@schmorgal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5867cb5-aeed-b081-543f-fd611c3c84c9@schmorgal.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Jan 14, 2023 at 02:49:07PM -0800, Doug Brown wrote:
> Hi Dan,
> 
> On 1/14/2023 12:01 AM, Dan Carpenter wrote:
> > Hi Doug,
> > 
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Doug-Brown/mmc-sdhci-pxav2-add-initial-support-for-PXA168-V1-controller/20230112-102921
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> > patch link:    https://lore.kernel.org/r/20230112022416.8474-6-doug%40schmorgal.com
> > patch subject: [PATCH v4 5/8] mmc: sdhci-pxav2: add optional core clock
> > config: riscv-randconfig-m041-20230113
> > compiler: riscv64-linux-gcc (GCC) 12.1.0
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > 
> > smatch warnings:
> > drivers/mmc/host/sdhci-pxav2.c:220 sdhci_pxav2_probe() warn: missing error code 'ret'
> 
> Thanks for passing this on. I definitely forgot an assignment to ret.
> Since this is correcting an error in my patch that hasn't been accepted
> yet, is it safe to assume I should omit those Reported-by tags from the
> next version of my patch, since they don't apply to the patch itself?
> 

These emails are from the kbuild team and not from me.  I just look them
over and hit the forward button.  I'm sure it helps the kbuild team in
their marketing when people use the tags...  Right now I'm applying to
jobs outside the Linux community so the tags give me a measurable thing
to say I've helped fix thousands of bugs or whatever...

I've always argued that there should be a different Fixes-from: tag for
people who find bugs during review (as opposed to just complaining about
white space which is its own reward and I do that for free).  So far I
haven't convinced anyone on this though.

Anyway, there isn't a policy one way or the other.  Some people add
them and some don't.  Some people add them below the --- cut off line,
but I don't know if that's deliberate or what the story is there.  That
seems like it might be a good compromise.

regards,
dan carpenter
