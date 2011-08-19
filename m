From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH --mmotm v8 0/3] Make fault injection available for MMC IO
Date: Fri, 19 Aug 2011 11:53:44 +0200
Message-ID: <CAJ0pr1-8Jnk1CKakWcS6T4Q3bAe7sF=5p8+9ou1+SbxsZM_Svw@mail.gmail.com>
References: <1312891671-28680-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64855 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721Ab1HSJxp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2011 05:53:45 -0400
In-Reply-To: <1312891671-28680-1-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>, akpm@linux-foundation.org, Linus Walleij <linus.ml.walleij@gmail.com>, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linaro-dev@lists.linaro.org, linux-mm@kvack.org, Per Forlin <per.forlin@linaro.org>

Hi Chris,

It's no longer necessary to merge this through the mm-tree since
Akinobu's patch "fault-injection: add ability to export fault_attr in
arbitrary directory" is in mainline.
Chris, would you mind merging the fault-injection patches in this
patchset to mmc-next once the mmc part of this patchset is acked and
accepted?

Regards,
Per

On 9 August 2011 14:07, Per Forlin <per.forlin@linaro.org> wrote:
> change log:
> =A0v2 - Resolve build issue in mmc core.c due to multiple init_module=
 by
> =A0 =A0 =A0removing the fault inject module.
> =A0 =A0- Export fault injection functions to make them available for =
modules
> =A0 =A0- Update fault injection documentation on MMC IO
> =A0v3 - add function descriptions in core.c
> =A0 =A0- use export GPL for fault injection functions
> =A0v4 - make the fault_attr per host. This prepares for upcoming patc=
h from
> =A0 =A0 =A0Akinobu that adds support for creating debugfs entries in
> =A0 =A0 =A0arbitrary directory.
> =A0v5 - Make use of fault_create_debugfs_attr() in Akinobu's
> =A0 =A0 =A0patch "fault-injection: add ability to export fault_attr i=
n...".
> =A0v6 - Fix typo in commit message in patch "export fault injection f=
unctions"
> =A0v7 - Don't compile in boot param setup function if mmc-core is
> =A0 =A0 =A0built as module.
> =A0v8 - Update fault injection documentation.
> =A0 =A0 =A0Add fail_mmc_request to boot option section.
>
> Per Forlin (3):
> =A0fault-inject: export fault injection functions
> =A0mmc: core: add random fault injection
> =A0fault injection: add documentation on MMC IO fault injection
>
> =A0Documentation/fault-injection/fault-injection.txt | =A0 =A08 +++-
> =A0drivers/mmc/core/core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 44 +++++++++++++++++++++
> =A0drivers/mmc/core/debugfs.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 27 +++++++++++++
> =A0include/linux/mmc/host.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A07 +++
> =A0lib/Kconfig.debug =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 | =A0 11 +++++
> =A0lib/fault-inject.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A06 files changed, 98 insertions(+), 1 deletions(-)
>
> --
> 1.7.4.1
>
>
