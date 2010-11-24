From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v1 4/4]use HPI to interrupt background operations
Date: Wed, 24 Nov 2010 12:33:33 +0800
Message-ID: <5D8008F58939784290FAB48F549751983125B43B49@shsmsx502.ccr.corp.intel.com>
References: <20101123084510.GE17754@intel.com>
 <AANLkTinF3+nUb8ugttyw-A_ss8cyX1iHFzG6bLdGf5d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13924 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766Ab0KXEdj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Nov 2010 23:33:39 -0500
In-Reply-To: <AANLkTinF3+nUb8ugttyw-A_ss8cyX1iHFzG6bLdGf5d6@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "Yuan, Hang" <hang.yuan@intel.com>

> > + =A0 =A0 =A0 opcode =3D card->ext_csd.hpi_cmd;
> > + =A0 =A0 =A0 if (opcode =3D=3D MMC_STOP_TRANSMISSION)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D MMC_RSP_R1B | MMC_CMD_AC;
> > + =A0 =A0 =A0 else if (opcode =3D=3D MMC_SEND_STATUS)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> > +
> > + =A0 =A0 =A0 memset(&cmd, 0, sizeof(struct mmc_command));
> > + =A0 =A0 =A0 cmd.opcode =3D opcode;
> > + =A0 =A0 =A0 cmd.arg =3D card->rca << 16 | 1;
> Maybe missing set the flags;
>             cmd.flags =3D flags;
>=20
> Thank you,
> Kyungmin Park

Thank you Park, will fix these bad mistake in the next version submissi=
on.
