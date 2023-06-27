Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B05EB64DC
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Jun 2023 12:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjF0M2K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Jun 2023 08:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjF0M2J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jun 2023 08:28:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193E0211C;
        Tue, 27 Jun 2023 05:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BD286118B;
        Tue, 27 Jun 2023 12:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6BFC433C8;
        Tue, 27 Jun 2023 12:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687868882;
        bh=JAPTrsaaiDxsHG4sjonMNTCuK1SM8J62tbw6yJvIexI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyKEdQcGMB2t3dzF+Av2nYXc2kvh68uHj76AFyt17GQxWfg+KsWl7tWgoJjgfEJoy
         IsP1w7KnocEBaAZq70BqFaC+oPRq3GOFZC6k9idVFjN5Ir306umjAAsCoxVGclqpmF
         aiPaHv+mnJzZym4kJ2vGJtyRjoFwBE4YxBNVDIR4=
Date:   Tue, 27 Jun 2023 14:27:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergei Antonov <saproj@gmail.com>
Cc:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        Jonas Jensen <jonas.jensen@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mmc: moxart: read scr register without changing byte
 order
Message-ID: <2023062746-dinner-custodian-f6c2@gregkh>
References: <20230627120549.2400325-1-saproj@gmail.com>
 <CABikg9yoY7rQ4gmBi7YACx0e+1xU3bLWVPho7xsre4HkXctf6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABikg9yoY7rQ4gmBi7YACx0e+1xU3bLWVPho7xsre4HkXctf6g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jun 27, 2023 at 03:11:17PM +0300, Sergei Antonov wrote:
> +ulf.hansson@linaro.org

That doesn't do anything given that there is no content here, sorry :(
