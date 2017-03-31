From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 2/2] mmc: host: s3cmci: allow probing from device tree
Date: Fri, 31 Mar 2017 09:25:34 +0200
Message-ID: <CAK8P3a2emCf=KtpCJMOaJnr89Gi+rCi0eun_vjb1wiYB=JR6jg@mail.gmail.com>
References: <1489799633-29278-1-git-send-email-sergio.prado@e-labworks.com> <1489799633-29278-3-git-send-email-sergio.prado@e-labworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36023 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbdCaHZg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Mar 2017 03:25:36 -0400
In-Reply-To: <1489799633-29278-3-git-send-email-sergio.prado@e-labworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergio Prado <sergio.prado@e-labworks.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Sat, Mar 18, 2017 at 2:13 AM, Sergio Prado
<sergio.prado@e-labworks.com> wrote:

>
> +static const struct of_device_id s3cmci_dt_match[] = {
> +       {
> +               .compatible = "samsung,s3c2410-sdi",
> +               .data = (void *)0,
> +       },
> +       {
> +               .compatible = "samsung,s3c2412-sdi",
> +               .data = (void *)1,
> +       },
> +       {
> +               .compatible = "samsung,s3c2440-sdi",
> +               .data = (void *)1,
> +       },
> +       { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
> +

The names don't match:

In file included from /git/arm-soc/drivers/mmc/host/s3cmci.c:14:0:
/git/arm-soc/drivers/mmc/host/s3cmci.c:1844:25: error:
'sdhci_s3c_dt_match' undeclared here (not in a function); did you mean
's3cmci_dt_match'?
 MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
                         ^
/git/arm-soc/include/linux/module.h:212:21: note: in definition of
macro 'MODULE_DEVICE_TABLE'
 extern const typeof(name) __mod_##type##__##name##_device_table  \
                     ^~~~
/git/arm-soc/include/linux/module.h:212:27: error:
'__mod_of__sdhci_s3c_dt_match_device_table' aliased to undefined
symbol 'sdhci_s3c_dt_match'
 extern const typeof(name) __mod_##type##__##name##_device_table  \
                           ^
/git/arm-soc/drivers/mmc/host/s3cmci.c:1844:1: note: in expansion of
macro 'MODULE_DEVICE_TABLE'
 MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
 ^~~~~~~~~~~~~~~~~~~
/git/arm-soc/scripts/Makefile.build:314: recipe for target
'drivers/mmc/host/s3cmci.o' failed

Can you send a fix?

       Arnd
