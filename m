Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD51CCA481
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Jul 2022 21:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiGFVUJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Jul 2022 17:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbiGFVUI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2022 17:20:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CB617E03
        for <linux-mmc@vger.kernel.org>; Wed,  6 Jul 2022 14:20:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sb34so29131093ejc.11
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2022 14:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2UCDhMKypb3YzjSBsPeyBiF2PeTe0+wdsZ8OfsVOrY=;
        b=sVFcjcHg2LfnGZPa5eF4aYhrF8RBJQ8TTDW3HHOvEbkPNvYtsAnwKb0K9pOEDOHtGr
         5MLLVwfPiM5Ww6QytB5EQA6Nv4l7GlTpEl6BHslrWSxudyACtyeDn+/ZFJZbD1bb3K9g
         TZc7d/Zj9PZ7ZFUq4pHASajIqU2e8MJPeQkohIwy1iMQWIy/F/DvYF5Pg7FC73nJd9sj
         zfOlEUGVa9h3Ia4yQ4Di7y12ZyeK4KqxzVmiemdXbK61C1koJczt92TGDpDqfG5fy06O
         a4NUSg/QnJ0l5x1VskRXEKu8EID1WZo1+FI60c+NpXidysJLk+EWwBPd3Ybclut9mea0
         NJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2UCDhMKypb3YzjSBsPeyBiF2PeTe0+wdsZ8OfsVOrY=;
        b=kqtr/XOSaAs2OZK8z9d2FrIfKqdOFokkkLsmzEA24R8RjwbiVxNiCkbTDjJBqj+XD4
         kY14EJ4B2R440XAtD8xzJo867mxQA3BLhOQ7gam+qY0pjQz8u3NkdYwBfayzpIVIQTxU
         u226rBWHHlAJlU/VzgHb60g2iXw/J5X1i1NYXuXH4Uh2ZqqUeQQf2LlqYPPJ+lMw7cN3
         TQbvsGbsACM6ysRBIeh4OFpTeCMcmh64dLbgVIOu4rfXI4ouvlDMpmMffIEwOZ6Jowgs
         hz7pelMzfg4lhBjauypmKzK+6vwAS8VqDIzNsvuf2L4gE6IDE60ypL7pOdRguTpzNLFv
         W1Ew==
X-Gm-Message-State: AJIora9FdK6KfPuM5LrtXQAQUV/t8vL5R75PWmcN5RzRzLkX6N5bwzZF
        jH2Zf2I/nVHN5MP1tipx6wm6s4EC1p3RQJxIoVun6Q==
X-Google-Smtp-Source: AGRyM1susXO3wYeoDf0WuEIfBGex3/UVxBp2DE1XLABw70yWDUei6RgD/KNu5S+8rGhboeMpSh2JSE05/UMRGugtit0=
X-Received: by 2002:a17:907:3f81:b0:6ff:1a3d:9092 with SMTP id
 hr1-20020a1709073f8100b006ff1a3d9092mr41342820ejc.319.1657142405356; Wed, 06
 Jul 2022 14:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220625050838.1618469-1-davidgow@google.com> <20220625050838.1618469-4-davidgow@google.com>
In-Reply-To: <20220625050838.1618469-4-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 17:19:54 -0400
Message-ID: <CAFd5g471_it8CQmBJnrhS=T3AgdfQF2tr4A9n=sYuWayovXmLw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] thunderbolt: test: Use kunit_test_suite() macro
To:     David Gow <davidgow@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>,
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

On Sat, Jun 25, 2022 at 1:10 AM David Gow <davidgow@google.com> wrote:
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
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
