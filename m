From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH RESEND] mmc:host:Fix error handling for calls to the function shdci_runtime_pm_get in the file sdhci.c
Date: Thu, 11 Feb 2016 13:08:08 -0500
Message-ID: <90967.1455214088@turing-police.cc.vt.edu>
References: <1455114866-27601-1-git-send-email-xerofoify@gmail.com>
 <56BC40EC.60301@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1455214088_2260P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59187 "EHLO
	omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751036AbcBKSIa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2016 13:08:30 -0500
In-Reply-To: <56BC40EC.60301@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Nicholas Krause <xerofoify@gmail.com>, ulf.hansson@linaro.org, ludovic.desroches@atmel.com, ivan.ivanov@linaro.org, sbranden@broadcom.com, haibo.chen@freescale.com, jszhang@marvell.com, marex@denx.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

--==_Exmh_1455214088_2260P
Content-Type: text/plain; charset=us-ascii

On Thu, 11 Feb 2016 10:06:04 +0200, Adrian Hunter said:
> On 10/02/16 16:34, Nicholas Krause wrote:
> > This fixes error handling for various function calls to

> pm_runtime_resume() returns 1 if the device's runtime PM status was already
> 'active', and -EACCES means that 'power.disable_depth' is different from 0
> (i.e. runtime pm not enabled), so this does not look coded correctly for
> those cases.

I wonder if Nicholas has a different meaning of the word "fixes".

Seriously Nicholas - you're wasting maintainer resources with all these
broken patches.  Please stop doing it.


--==_Exmh_1455214088_2260P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVrzOCAdmEQWDXROgAQL29w/9GDaZe0ywPAiH5zDXrXRouCeuG+f7yTuJ
+IO4x97BriJsRF3IZYnn3aqIIQ1fi9BihVl1U0RB3kNln0F0k/gF2wKYrfUpB99Z
VEuTXk+Omv8sS9xslPE2HfIqvu1v2cxuZw0QAYn6sgK4SJbg7d+JQor1LAWbSGbF
uhkWDj06ES8Qd87Melsd1Rk9xPRkcpld4s2fSDiKxCQwrFREDabTfyC0J/kCvx3H
oWHQQtfxFM6C+AqowXsoJKJne182IWJ/uUedwDIpAkSyVX5GHGqXkM54qKCzKFDk
XsE3YiUI6sQb4EBGisLTI3+yVNmzFHI10seJQvWYiwPiblEFcKyONyFkOEC4TAtX
hjUsfXj8hLLcKUS7WPf2kQq4aexiEDJ0T4KdHNGqm0FrXDKKIZE2Y8IlyWg4+0dR
8JzPlNouk+Yq+8Ql0tpr0a434o0DATq6n2yIWDUuVYV6rodTNnH5YZRk2yadtqSJ
GWeG+zHIe1JGA2K2atMxJD0W+ccT3uKTJmdS6L06OQOwG9EZcFsIrddxuPFkoYMx
6JEom0RuQgyUaTSDRW1WMnxj0azC2mAYEUDCTq9WdvJSALfF8Di5gk+Ujw0/YxNx
9WFdd2fMlyfLuJa/5XLLLjwPA4tg9z4NqPpUei/u+y5INCrjwU+iylmtRH8p/2BP
UWWyBp7I9Ro=
=6qzV
-----END PGP SIGNATURE-----

--==_Exmh_1455214088_2260P--
