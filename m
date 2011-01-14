From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: mmci: U300 "sync with blockend" broken for multi-block?
Date: Fri, 14 Jan 2011 22:44:39 +0000
Message-ID: <20110114224439.GR15996@n2100.arm.linux.org.uk>
References: <AANLkTimYb6TxLj4SamxRwUgykf9JyW5y9gbejOUXqZ7K@mail.gmail.com> <20110101121048.GB25924@n2100.arm.linux.org.uk> <AANLkTi=4SrxX-oCx-XXd+oib64j8RhMLdsQD1oWGxgU1@mail.gmail.com> <20110105164344.GD8638@n2100.arm.linux.org.uk> <AANLkTim4J8xrj9axhsu4=_7YkEy_ndiJ6cjDNf2WfzEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46895 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab1ANWpw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Jan 2011 17:45:52 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim4J8xrj9axhsu4=_7YkEy_ndiJ6cjDNf2WfzEg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Rabin Vincent <rabin@rab.in>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Ulf Hansson <Ulf.Hansson@stericsson.com>, Sebastian Rasmussen <Sebastian.Rasmussen@stericsson.com>, linux-mmc@vger.kernel.org

On Fri, Jan 14, 2011 at 09:13:05PM +0100, Linus Walleij wrote:
> 2011/1/5 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>=20
> > Any chance of pr_debug'ing the complete status register each time y=
ou
> > service an interrupt? =A0You'll probably need to set the kernel log
> > buffer fairly large to ensure that you capture everything.
>=20
> I did this test now.

Just to complete the picture, can I see the patch between the version
which produced this and mainline?
