Return-Path: <SRS0=qSan=CQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6FBC43461
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Sep 2020 10:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B270216C4
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Sep 2020 10:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599476281;
	bh=sBvP/Dm6X8mLCA792XuRLZCAgAWBJ0s1jurDSSE6Hy8=;
	h=Date:From:List-Id:To:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=knWgIShDrN8tZ7KxaqwnDOTv6XD5jzukpEhMJkbza8Jk6+jZuhgZrZ5OiVx8iaAtT
	 QInxFBmqbfTQ4nsQdEzKQw/32icTIBvekwGpZenaGghZH8Bls1PaU/4zQNtXqp27c0
	 7ZpCF/S8QjhnT3Wv5eotkUj3rGL2+WxyWSnUhc7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgIGK55 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:57:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35961 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbgIGK5B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Sep 2020 06:57:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id w1so12363954edr.3;
        Mon, 07 Sep 2020 03:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PU4a2Iw51Q8DsKvI6VFHu9Hjx5eXu6HfkDcfoQ9YGb4=;
        b=L2llLIigWNy2D97AlCIML2XZdr1P01SZHT8KO1FrucNClcs5qmCMrscD1rA8OWVDZx
         KJbapIIHZDTFcbFvSphwCegqHLoFPIpo+M2Ee0nN88+vASiEbO5sw+dNIqfdIN2kO1u4
         MdsPtmxf+K4F9SRiPnuWoneZb7T5OVvhv7AZmM8Ui+eh2UseH+lM9DPlFokd/n3BYQ9R
         UhIAQnSqGPp7/Sl/C4AmzzNVaUrdWLSJL7Q22gC3jnEznbIKlrJ3oZZ1o9BXCPSe8SgB
         DOzQxn7J819NtjcQpP6BD2OvXgwLEojSTBzXh2p1yz4HdC3nLl1dTd7lIcl+OVgaJWCf
         8Obg==
X-Gm-Message-State: AOAM5327F4d025PDdmr5S9bYRNJhGDHqiRw4CjcPqebusqUvQCqmSn9y
        Zt1Wcjbc98Fv0HYWJAuUsvE=
X-Google-Smtp-Source: ABdhPJw0jw90H6QL7lT1z9qlgXoIspfVloP9ZRO343uzPFU+HTja+C3weJh9+fjqC0/vTxzbABRumQ==
X-Received: by 2002:a05:6402:12d1:: with SMTP id k17mr20588884edx.323.1599476218174;
        Mon, 07 Sep 2020 03:56:58 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id v4sm15052441eje.39.2020.09.07.03.56.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Sep 2020 03:56:56 -0700 (PDT)
Date:   Mon, 7 Sep 2020 12:56:51 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
List-Id: <soc.lore.kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] ARM: mach: samsung: S3C cleanup for v5.10
Message-ID: <20200907105622.GA31259@kozik-lap>
References: <20200831154751.7551-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200831154751.7551-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Aug 31, 2020 at 05:47:51PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> I applied Arnd's series for Samsung S3C cleanup, plus multiple fixes from me
> and other developers.  This also pulls branch from Mark Brown.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
> 
>   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-s3c-5.10
> 
> for you to fetch changes up to a1342f6a9ff88ad88ff7a981c53ae0869c94d243:
> 
>   ARM: s3c: Avoid naming clash of S3C24xx and S3C64xx timer setup (2020-08-28 16:38:55 +0200)
> 
> ----------------------------------------------------------------
> Samsung S3C24xx and S3C64xx machine code cleanup for v5.10
> 
> Big cleanup for the Samsung S3C24xx and S3C64xx platforms, although it
> also touches files shared with S5Pv210 and Exynos.  This is mostly Arnd
> Bergmann work which Krzysztof Kozlowski took over, rebased and polished.
> 
> The goal is to cleanup, merge and finally make the Samsung S3C24xx and
> S3C64xx architectures multiplatform.  The multiplatform did not happen
> yet here - just cleaning up and merging into one arch/arm/mach-s3c
> directory.  However this is step forward for multiplatform or at least
> to keep this code still maintainable.
> 
> This pulls also branch with changes for Samsung SoC sound drivers from
> broonie/sound because the cleanups there were part of this series and
> all further patches depend on them.

Hi Arnd and Olof,

+Cc Ulf,

This might conflict with Ulf Hansson's mmc tree around MMC_SDHCI_S3C.
Possible resolution:
-depends on PLAT_SAMSUNG || COMPILE_TEST
+depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST

Best regards,
Krzysztof
