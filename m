From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Asus VivoBook Flip TP202NA-EH012T EMMC problem
Date: Wed, 4 Sep 2019 11:33:07 +0200
Message-ID: <CAPDyKFqKxSo50FSmesuOBz+FfE_DEFsZmEHD5CiU8SORv1Jrow@mail.gmail.com>
References: <d355e790-7c60-5681-3ea5-dc4fd6206628@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d355e790-7c60-5681-3ea5-dc4fd6206628@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?w5N2w6FyaQ==?= <ovari123@zoho.com>, Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

+ Kai Heng Feng

On Sat, 31 Aug 2019 at 11:43, =C3=93v=C3=A1ri <ovari123@zoho.com> wrote:
>
> Hello,
>
> As per https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1818407/comme=
nts/26 here is an email.
>
> Information is provided at https://bugs.launchpad.net/ubuntu/+source/linu=
x/+bug/1818407/comments/32
>
> Please advise what else you require.

Future wise, rather than solely sending links to bugreports, please
copy the relevant data into the email. Moreover, we don't normally
care that much about "old" kernels, unless problems exists on the
latest kernels as well.

Anyway, by following the above links, I figured this is about
sdhci-pci and you get a CRC problem when switching to HS400 mode.

[ 3.673358] mmc0: error -84 whilst initialising MMC card
[ 3.808029] mmc0: mmc_select_hs400 failed, error -84

A wild shot is to try out my fixes branch, which holds the following
below queued fix, that might solve the problem if it's a regression.

commit 8ad8e02c2fa70cfddc1ded53ba9001c9d444075d
Author: Jan Kaisrlik <ja.kaisrlik@gmail.com>
Date:   Tue Aug 20 13:42:29 2019 +0200
Revert "mmc: core: do not retry CMD6 in __mmc_switch()"

git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git fixes

Kind regards
Uffe
