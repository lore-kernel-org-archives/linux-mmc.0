From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [GIT PULL] MMC fixes for 2.6.37
Date: Thu, 23 Dec 2010 18:17:50 +0900
Message-ID: <AANLkTine-9YC7062cNaPG+iieBD2bcttx2b3sf3sveKP@mail.gmail.com>
References: <m3pqss50lr.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <m3pqss50lr.fsf@pullcord.laptop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

Can you include the s5pc210 external clock support? without this,
s5pc210 boards doesn't use the SDHCI.

I think Ben is busy with other task so can't reply your ack request.

To Ben,
Can you ack the s5pc210 patch?

Thank you,
Kyungmin Park

On Thu, Dec 23, 2010 at 5:56 PM, Chris Ball <cjb@laptop.org> wrote:
> Linus,
>
> Please pull from:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git for-linu=
s
>
> to fix a regression in resume-from-hibernate, and two minor driver bu=
gs
> on Atmel controllers. =A0These have been tested in linux-next. =A0Tha=
nks.
>
> The following changes since commit 0a59228168d3722b71f8e3dbc623316fb4=
be78f4:
>
> =A0Merge git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux=
-tile (2010-12-18 10:28:54 -0800)
>
> are available in the git repository at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git for-linu=
s
>
> Nicolas Ferre (1):
> =A0 =A0 =A0mmc: atmel-mci: fix multiblock SDIO transfers
>
> Takashi Iwai (1):
> =A0 =A0 =A0mmc: Fix re-probing with PM_POST_RESTORE notification
>
> Yauhen Kharuzhy (1):
> =A0 =A0 =A0mmc: at91_mci: fix multiblock SDIO transfers
>
> =A0arch/arm/mach-at91/include/mach/at91_mci.h | =A0 =A02 ++
> =A0drivers/mmc/core/core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 +
> =A0drivers/mmc/host/at91_mci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 1=
3 +++++++++----
> =A0drivers/mmc/host/atmel-mci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 18 =
++++++++++++------
> =A04 files changed, 24 insertions(+), 10 deletions(-)
>
> --
> Chris Ball =A0 <cjb@laptop.org>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
