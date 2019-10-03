From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] MMC: Ingenic: Add support for JZ4760 and support for LPM.
Date: Thu, 3 Oct 2019 12:00:42 +0200
Message-ID: <CAPDyKFo0aR2fhCd8qCNAf7hoXSjV+9vG1BqB6vEM=B9Vpmpovg@mail.gmail.com>
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com> <1567669089-88693-5-git-send-email-zhouyanjie@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567669089-88693-5-git-send-email-zhouyanjie@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhou Yanjie <zhouyanjie@zoho.com>
Cc: linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Cercueil <paul@crapouillou.net>, Mathieu Malaterre <malat@debian.org>, YueHaibing <yuehaibing@huawei.com>, Ezequiel Garcia <ezequiel@collabora.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, syq@debian.org, jiaxun.yang@flygoat.com
List-Id: linux-mmc@vger.kernel.org

On Thu, 5 Sep 2019 at 09:40, Zhou Yanjie <zhouyanjie@zoho.com> wrote:
>
> 1.add support for probing mmc driver on the JZ4760 Soc from Ingenic.
> 2.add support for Low Power Mode of Ingenic's MMC/SD Controller.

Normally we try to make "one" change per patch, unless there are some
good reasons not to.

In this case, it seems like you should rather split this patch into
two separate pieces. Can you please do that?

Additionally, please change the prefix for the commit message header
to start with "mmc: jz4740:"

[...]

Kind regards
Uffe
