Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C073CCA47E
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jun 2022 20:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354321AbiFUUXh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354327AbiFUUXU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2022 16:23:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCED01D31D
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2022 13:23:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g25so29821795ejh.9
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2022 13:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhJQcMlSnFoacV2KwcdFXpjtba+IaB/sZyuFW7tBT+c=;
        b=epbu3P3cY++CvsJWFX9rqxwKCIZ1HaftiAiLiPKOBX/SuNxREsfwYANixXlw73aJoD
         YeSiKTf/2tQl+U/ndTBwzMKwyRcfRbfGJQYyCGQheC+iSe7QGhr+yOInJxXAPDdgxMwn
         8azIXpbuQbkO2keBtOuDV5cOiHCaZ2eHLPSofuGcChQDzjNB37jSujXaFs/efxWfjhPa
         5ccm25uoo7LlIhqoL2UDRepNfaqqo2EQqIU2Sc/EGRhbcViiNdLTtWAr9ggYGWqdv6OH
         nEr/og2fbKcTY/8Uj3GZ6+T6IxWfFROA8Z0i5HxCY9NvKeXQcb7A6FR6NarbeSee6hC2
         ahmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhJQcMlSnFoacV2KwcdFXpjtba+IaB/sZyuFW7tBT+c=;
        b=ocpu48EGDOVaS4+7ihq6Pf0VcVe/9aWzj27chht4wYIJ8nal4h0ie4moQhZ/SsuIqE
         1UyftddVGHFTMcqHVbzCAT5W0dnr/DgpCCoil0mL76HHqYy/jamX/hKvmByRkgzokQBx
         T0crRuDGCPN9fXZweV0cUhSa1x3XNmqWPjWwLIOO4Un/PwYjSTJSQg168z2YtOjV+p8B
         ZAcCWtx+WReN8Kxv/NZ554KLJe7Go7kr/2418w9ZUe6H4M3jH4Edc6nvH3yGrhuAvkls
         ja4lwd/I/ELr+ETGNsQZ5HTYsz7hgYPOg+3NUQsu9Trwnq/8B6NYYTBNlzEBXV/EV7Kf
         vnpQ==
X-Gm-Message-State: AJIora9mBEWydDT71WBDGqQrQ+FqmyrnAA/EyyOgI+CPUIF4mOiKXy4b
        b7Riiilrw3tHBo/EtvwJ3ksGKZQJOnYO5oubTDVyoA==
X-Google-Smtp-Source: AGRyM1syldNCsF4yTG1CqNeyR+d//+kPIDUAn8FkfXpI6Ib8/JA3UGUsecd0zG+9GJgtedGAH6mxDaNCH8juW6fW3Jg=
X-Received: by 2002:a17:906:c193:b0:718:d076:df7 with SMTP id
 g19-20020a170906c19300b00718d0760df7mr28212396ejz.358.1655842996119; Tue, 21
 Jun 2022 13:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220621085345.603820-1-davidgow@google.com> <20220621085345.603820-4-davidgow@google.com>
In-Reply-To: <20220621085345.603820-4-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 21 Jun 2022 13:23:04 -0700
Message-ID: <CAGS_qxpXkTZiebd=zqJTY8wvSs1TuBvBuDdxYkPEjwnkQ+ir2g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] thunderbolt: test: Use kunit_test_suite() macro
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>, Paraschiv@google.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jun 21, 2022 at 1:54 AM David Gow <davidgow@google.com> wrote:
>
> The new implementation of kunit_test_suite() for modules no longer
> conflicts with module_init, so can now be used by the thunderbolt tests.
>
> Also update the Kconfig entry to enable the test when KUNIT_ALL_TESTS is
> enabled.
>
> This means that kunit_tool can now successfully run and parse the test
> results with, for example:
>         ./tools/testing/kunit/kunit.py run --arch=x86_64 \
>         --kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_USB4=y \
>         'thunderbolt'

With this, we can maybe revive
https://lore.kernel.org/lkml/20220214184104.1710107-1-dlatypov@google.com
by tacking it onto this series if a v3 goes out.
There is the open question of whether we should put UML-specific
config options in the file, though.

If we decide we don't want that, then we can defer it until I send out
the patches for "repeatable --kunitconfig" and we can add the
uml_pci.config file.

>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Daniel Latypov <dlatypov@google.com>

LGTM.
