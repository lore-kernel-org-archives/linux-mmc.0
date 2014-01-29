From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH v2] mmc-utils: add eMMC 5.0 FFU support
Date: Wed, 29 Jan 2014 01:34:10 +0000
Message-ID: <86txcnzi3x.fsf@void.printf.net>
References: <1390506264-17107-1-git-send-email-grundler@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42648 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754026AbaA2BeM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 20:34:12 -0500
In-Reply-To: <1390506264-17107-1-git-send-email-grundler@chromium.org> (Grant
	Grundler's message of "Thu, 23 Jan 2014 11:44:24 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>

Hi Grant, still one warning/error left:

On Thu, Jan 23 2014, Grant Grundler wrote:
> V2:
> Fix compiler borkage in use of strncmp().
> Use '\0' instead of 0 in char assignment.

=CE=BB make
cc  -Wall -Werror -Wuninitialized -Wundef -D_FILE_OFFSET_BITS=3D64 -D_F=
ORTIFY_SOURCE=3D2 -g -O2 -Wp,-MMD,./.mmc_cmds.o.d,-MT,mmc_cmds.o -c mmc=
_cmds.c
mmc_cmds.c: In function =E2=80=98do_firmware_update=E2=80=99:
mmc_cmds.c:1290:4: error: format =E2=80=98%d=E2=80=99 expects argument =
of type =E2=80=98int=E2=80=99,
but argument 3 has type =E2=80=98size_t=E2=80=99 [-Werror=3Dformat=3D]
    fwsize, fwfilename, ret);
    ^
cc1: all warnings being treated as errors

--=20
Chris Ball   <chris@printf.net>   <http://printf.net/>
