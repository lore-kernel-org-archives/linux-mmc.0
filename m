Return-Path: <SRS0=ySr4=3G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B54C33CB1
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jan 2020 14:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F99B2083E
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jan 2020 14:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="BW+cTQ8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgAQOLt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:11:49 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:2136 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQOLs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Jan 2020 09:11:48 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47zjfp2SzTzJv;
        Fri, 17 Jan 2020 15:11:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1579270306; bh=XmEtgDG0oQyn3sFStAiiuxUsYkO0wEPHkuJs+F8ucvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BW+cTQ8x5vNorbyo8Z9YUUvoj8OQUvY6DvyE5ZhRGTXoKj2jyQz5grz6N2ihuhJrU
         Fj66MNklsymohTWe4x0dI1IzLMR0MadoMO7uGnpSk6Lo8svaAGZ77PmudPUpndUSmy
         jEcC6ZIUmovIhJK5ccrwPrYq2i5pPuFWsJ6uE5JLqvgLs/X9RJJnC4jXqNiBig7Y63
         vAm56mXPBkaMEbtwLW7fVs9fdr91CvzTorlpaye8J6GLI/Rf0e42TIlO1nX6c5XHUY
         Qo0cOv0dKQOx/YniIRk8MUI8JYwHoPLjrDnpeyIkWky7QxWYEiVrToiwKKz+0C9mMX
         sxEMafgp9SRzw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Fri, 17 Jan 2020 15:11:45 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lucas Stach <dev@lynxeye.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mmc: tegra: fix SDR50 tuning override
Message-ID: <20200117141145.GD26135@qmqm.qmqm.pl>
References: <9aff1d859935e59edd81e4939e40d6c55e0b55f6.1578390388.git.mirq-linux@rere.qmqm.pl>
 <CAPDyKFqXmbnH_NWZZTHHCE+Lt-f3JHAhJ8-=aoKNEPyQed44YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFqXmbnH_NWZZTHHCE+Lt-f3JHAhJ8-=aoKNEPyQed44YA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 16, 2020 at 03:39:54PM +0100, Ulf Hansson wrote:
> On Tue, 7 Jan 2020 at 10:47, Micha³ Miros³aw <mirq-linux@rere.qmqm.pl> wrote:
> >
> > Commit 7ad2ed1dfcbe inadvertently mixed up a quirk flag's name and
> > broke SDR50 tuning override. Use correct NVQUIRK_ name.
> >
> > Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
> > Cc: <stable@vger.kernel.org> # 4f6aa3264af4: mmc: tegra: Only advertise UHS modes if IO regulator is present
> 
> I am dropping this tag, simply because I don't understand what it should tell.

It tells the maintainer that he needs to cherry-pick this commit if
its not in particular stable version already. I guess this is only
for v4.4, as v4.9+ already have it, and v3.16 does not include the
Fixed commit.

Best Regards,
Micha³ Miros³aw
