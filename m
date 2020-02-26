Return-Path: <SRS0=M0wQ=4O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A7BC4BA13
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Feb 2020 15:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D258B24683
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Feb 2020 15:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582731301;
	bh=+DMv/uTWjCZFTZDOY8xJulnsfcRlRlNP6wz9QgYJFSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x34aRLv+eEf8kKede8WyYrJpMObDCne2p7L3IDlDaoGeYnKOLdyVmMr6QVfrYBEad
	 wVtvBY/oNI3n4i4E4u/1ZlKjhhRlPpdU7hwcyqzddzjnUFTJy3j2CVbM2mToKSif3W
	 PgpgawA1MdQs46CSmzETaFkkcC2KQYUXqGrZGPFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgBZPfB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:35:01 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38058 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbgBZPfB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Feb 2020 10:35:01 -0500
Received: by mail-oi1-f196.google.com with SMTP id r137so3437501oie.5;
        Wed, 26 Feb 2020 07:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bmr+8NPwfz+6SLFnXLs13Acg+Mnt/J7K/fZ7YI8qSb0=;
        b=YZ92gfq0at7jLbkQalEgBhxQfDvvROAVoRYYkA3IYQaAjr2l72gmHf8ZVbn/pRBdPc
         tA/idRFJuUD8FblRY7pfRhwC+wNk76dEGLf3GAnKPArYftFDWYSgQt0zu4J8l3OjsGUi
         GxHYvvOLkgvAZn0XKgFbZ8xajQL3skSJcrotsB+Dycv91YmR1SYZ3Td82NDOwmaRpHao
         ltJ6Ef+dndYwfoqUby/pOgeA4GJ+QvJPGL6308yMB+PeDcE3EkkIuUWldoF9wpBuXcsp
         WCUVA3Y2lsw0cTKncVVSQ2peF+nw5xqP1zGTeNto4NHUXn6mj6mlOakP8q1LxXtabInB
         8X6Q==
X-Gm-Message-State: APjAAAUYcZFzTdlEnsifqKkUjU8J/xNBr3rg3c8wLPjR3CwlxvDnvVCB
        6vPZT2Qp+Ug/FPJTBlfHzA==
X-Google-Smtp-Source: APXvYqyHUnpLxu/riNnSSfDyvvYs4QZHHYnlgt+uqnMpGbtPWPsEKcDtzAWDevIt0bUYTrayLJRwgw==
X-Received: by 2002:aca:b703:: with SMTP id h3mr3596325oif.148.1582731300302;
        Wed, 26 Feb 2020 07:35:00 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l12sm891627oth.9.2020.02.26.07.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:34:59 -0800 (PST)
Received: (nullmailer pid 13066 invoked by uid 1000);
        Wed, 26 Feb 2020 15:34:58 -0000
Date:   Wed, 26 Feb 2020 09:34:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: arasan: Document
 'xlnx,versal-8.9a' controller
Message-ID: <20200226153458.GA13010@bogus>
References: <1582115313-115667-1-git-send-email-manish.narani@xilinx.com>
 <1582115313-115667-2-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582115313-115667-2-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 19 Feb 2020 17:58:32 +0530, Manish Narani wrote:
> Add documentation for 'xlnx,versal-8.9a' SDHCI controller followed by
> example.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt      | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
