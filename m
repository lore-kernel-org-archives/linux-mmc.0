From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: hide clock message when card is resuming
Date: Thu, 20 Apr 2017 16:50:42 +0300
Message-ID: <B42FBB3A-66CF-4EAA-A1BF-002C99D486C5@gmail.com>
References: <CGME20170419145649epcas2p428230d6fa04b2b6905e500f7b0a33297@epcas2p4.samsung.com> <1492613756-16740-1-git-send-email-al.kochet@gmail.com> <25b5c103-ed7c-d03f-d285-bde651691ba1@samsung.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33049 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031457AbdDTNup (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Apr 2017 09:50:45 -0400
In-Reply-To: <25b5c103-ed7c-d03f-d285-bde651691ba1@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org


> 20 =D0=B0=D0=BF=D1=80. 2017 =D0=B3., =D0=B2 13:06, Jaehoon Chung =
<jh80.chung@samsung.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0=
):
>=20
> I think you are not using the latest kernel. which version do you use?
>=20
> =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3Dce69e2fea093b7fa3991c87849c4955cd47796c9
>=20
> Could you check this?

Commit ce69e2fea093 (=C2=ABmmc: dw_mmc: silent verbose log when calling =
from PM context=C2=BB) fix
issue I have. So my patch not needed anymore.

I use 4.10.10, probably ce69e2fea093b7fa3991c87849c4955cd47796c9 should =
be backported to 4.10 branch.
4.9 branch doesn=E2=80=99t have commit e9748e0364fe ("mmc: dw_mmc: force =
setup bus if active slots exist=C2=BB) what
cause the problem.

I=E2=80=99ll send request to stable.

Regards,
Alexander.

