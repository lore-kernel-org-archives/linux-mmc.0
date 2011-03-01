From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC,PATCHv3 0/3] sdhci runtime_pm implementation
Date: Tue, 1 Mar 2011 15:30:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1103011528230.2034-100000@iolanthe.rowland.org>
References: <AANLkTik5HVxoOCH1ZVj50nUsCA5E04Y0J0RaWw7_KyKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51147 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756459Ab1CAUaa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 15:30:30 -0500
In-Reply-To: <AANLkTik5HVxoOCH1ZVj50nUsCA5E04Y0J0RaWw7_KyKw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org

On Tue, 1 Mar 2011, Pierre Tardy wrote:

> >> > Other drivers do it, but they use PCI PME# instead of interrupts=
=2E
> >> Could you please elaborate?
> >> My understanding is that PCI PME will generate MSI, which translat=
e in
> >> interrupt.
> >
> > It depends on the platform. =A0On systems with ACPI, PCI PME genera=
tes an
> > ACPI I/O event, which is handled by the ACPI and PM cores. =A0It do=
es not
> > invoke the device driver's interrupt handler.
> So, let's say, in the ACPI case, if the interrupt handler dont get
> called, how would the driver know that he got a sdcard insert event,
> and trigger a mmc_rescan() ?

When the ACPI and PCI cores process the PME event, they call
pm_runtime_resume().  The driver's runtime_resume routine would read
the device status and see the insert event, which would cause it to
trigger mmc_rescan().

Alan Stern

