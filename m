From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc-utils: add eMMC 5.0 FFU support
Date: Thu, 23 Jan 2014 19:28:01 +0000
Message-ID: <86fvoe1ose.fsf@void.printf.net>
References: <1390501260-8730-1-git-send-email-grundler@chromium.org>
	<86ob321qw0.fsf@void.printf.net>
	<CANEJEGvpr3TB4PyfSOViy1D6avZQuKL7Km0DhnA5BiXDkYPV1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60961 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbaAWT2D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jan 2014 14:28:03 -0500
In-Reply-To: <CANEJEGvpr3TB4PyfSOViy1D6avZQuKL7Km0DhnA5BiXDkYPV1w@mail.gmail.com>
	(Grant Grundler's message of "Thu, 23 Jan 2014 11:20:46 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>

Hi Grant,

On Thu, Jan 23 2014, Grant Grundler wrote:
> You can directly pull into a local branch/review with:
>     git fetch https://chromium.googlesource.com/chromiumos/third_part=
y/mmc-utils
> refs/changes/21/179621/2 && git cherry-pick FETCH_HEAD

Thanks, that worked fine.  Now I'm seeing:

cc  -Wall -Werror -Wuninitialized -Wundef -D_FILE_OFFSET_BITS=3D64 -D_F=
ORTIFY_SOURCE=3D2 -g -O2 -Wp,-MMD,./.mmc_cmds.o.d,-MT,mmc_cmds.o -c mmc=
_cmds.c
mmc_cmds.c: In function =E2=80=98do_firmware_update=E2=80=99:
mmc_cmds.c:1201:53: error: macro "strncmp" requires 3 arguments, but on=
ly 2 given
if (strncmp(argv[4], "--I_want_to_destroy_my_drive")) {
                                                   ^
mmc_cmds.c:1201:6: error: the address of =E2=80=98strncmp=E2=80=99 will=
 always evaluate as =E2=80=98true=E2=80=99 [-Werror=3Daddress]
if (strncmp(argv[4], "--I_want_to_destroy_my_drive")) {
    ^
mmc_cmds.c:1290:4: error: format =E2=80=98%d=E2=80=99 expects argument =
of type =E2=80=98int=E2=80=99, but argument 3 has type =E2=80=98size_t=E2=
=80=99 [-Werror=3Dformat=3D]
    fwsize, fwfilename, ret);
    ^
cc1: all warnings being treated as errors
make: *** [mmc_cmds.o] Error 1

--=20
Chris Ball   <chris@printf.net>   <http://printf.net/>
