From: Johan RUDHOLM <johan.rudholm@stericsson.com>
Subject: RE: [PATCH] mmc: core: check for zero length ioctl data
Date: Fri, 2 Dec 2011 16:18:35 +0100
Message-ID: <E2E6AC6BFAD06343BA2D97432459C1B6071D93F78A@EXDCVYMBSTM005.EQ1STM.local>
References: <1322035558-1127-1-git-send-email-johan.rudholm@stericsson.com>
	<87ipm0kvay.fsf@laptop.org>
	<E2E6AC6BFAD06343BA2D97432459C1B6071D93F3BD@EXDCVYMBSTM005.EQ1STM.local>
 <87vcpzhxg1.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_E2E6AC6BFAD06343BA2D97432459C1B6071D93F78AEXDCVYMBSTM00_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:33666 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754065Ab1LBPSv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2011 10:18:51 -0500
In-Reply-To: <87vcpzhxg1.fsf@laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Per FORLIN <per.forlin@stericsson.com>, Ulf HANSSON <ulf.hansson@stericsson.com>

--_002_E2E6AC6BFAD06343BA2D97432459C1B6071D93F78AEXDCVYMBSTM00_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Chris Ball wrote:
>=20
> On Fri, Dec 02 2011, Johan RUDHOLM wrote:
> >> Would you be able to share the userspace code that you've been using
> >> with this, please?  I'd like to start collecting a repository of
> >> userspace code showing common uses of this ioctl.
> >
> > Yes, I think so. How would you prefer to receive such a contribution
> -
> > as a .tar.gz, a patch, a plain text attachment? Do you have any idea
> > where such a repository would live?
>=20
> Any of these sounds fine, whichever works best for you.  When
> the repository exists, I think it will live somewhere like:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git

Ok! Looking forward to this :) I've attached the sample code as a .tar.gz.

Kind regards, Johan



--_002_E2E6AC6BFAD06343BA2D97432459C1B6071D93F78AEXDCVYMBSTM00_
Content-Type: application/x-gzip; name="rwextcsd.tar.gz"
Content-Description: rwextcsd.tar.gz
Content-Disposition: attachment; filename="rwextcsd.tar.gz"; size=1574;
	creation-date="Fri, 02 Dec 2011 16:17:11 GMT";
	modification-date="Fri, 02 Dec 2011 15:42:35 GMT"
Content-Transfer-Encoding: base64

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

--_002_E2E6AC6BFAD06343BA2D97432459C1B6071D93F78AEXDCVYMBSTM00_--
