From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] mmc-utils: add eMMC 5.0 FFU support
Date: Thu, 23 Jan 2014 11:30:27 -0800
Message-ID: <CANEJEGsYEF7pyWDHf2014hmJhEjJCYEfe1k+xso26tPY9cocEg@mail.gmail.com>
References: <1390501260-8730-1-git-send-email-grundler@chromium.org>
	<86ob321qw0.fsf@void.printf.net>
	<CANEJEGvpr3TB4PyfSOViy1D6avZQuKL7Km0DhnA5BiXDkYPV1w@mail.gmail.com>
	<86fvoe1ose.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:63700 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbaAWTa1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jan 2014 14:30:27 -0500
Received: by mail-oa0-f47.google.com with SMTP id m1so2644736oag.34
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jan 2014 11:30:27 -0800 (PST)
In-Reply-To: <86fvoe1ose.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Grant Grundler <grundler@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>

On Thu, Jan 23, 2014 at 11:28 AM, Chris Ball <chris@printf.net> wrote:
> Hi Grant,
>
> On Thu, Jan 23 2014, Grant Grundler wrote:
>> You can directly pull into a local branch/review with:
>>     git fetch https://chromium.googlesource.com/chromiumos/third_par=
ty/mmc-utils
>> refs/changes/21/179621/2 && git cherry-pick FETCH_HEAD
>
> Thanks, that worked fine.  Now I'm seeing:
>
> cc  -Wall -Werror -Wuninitialized -Wundef -D_FILE_OFFSET_BITS=3D64 -D=
_FORTIFY_SOURCE=3D2 -g -O2 -Wp,-MMD,./.mmc_cmds.o.d,-MT,mmc_cmds.o -c m=
mc_cmds.c
> mmc_cmds.c: In function =E2=80=98do_firmware_update=E2=80=99:
> mmc_cmds.c:1201:53: error: macro "strncmp" requires 3 arguments, but =
only 2 given
> if (strncmp(argv[4], "--I_want_to_destroy_my_drive")) {


Sorry - I fixed that yesterday but apparently didn't update the "git
format-patch" output I used to send the patch out today. /o\

Will respin ASAP. and resend. *sigh*

apologies,
grant

>                                                    ^
> mmc_cmds.c:1201:6: error: the address of =E2=80=98strncmp=E2=80=99 wi=
ll always evaluate as =E2=80=98true=E2=80=99 [-Werror=3Daddress]
> if (strncmp(argv[4], "--I_want_to_destroy_my_drive")) {
>     ^
> mmc_cmds.c:1290:4: error: format =E2=80=98%d=E2=80=99 expects argumen=
t of type =E2=80=98int=E2=80=99, but argument 3 has type =E2=80=98size_=
t=E2=80=99 [-Werror=3Dformat=3D]
>     fwsize, fwfilename, ret);
>     ^
> cc1: all warnings being treated as errors
> make: *** [mmc_cmds.o] Error 1
>
> --
> Chris Ball   <chris@printf.net>   <http://printf.net/>
