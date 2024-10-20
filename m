Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0C11C83
	for <linux-mmc@vger.kernel.org>; Sun, 20 Oct 2024 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729454217; cv=pass; b=aGoyPfFO6Lo+4kxeZtdvA2Ao5QnHiRR9to5WDJu9mLBIg1hGUz5HxWANswRzSik4NUNeGy5s23mXmFRfSF+bwTAloUkwmNONgkuY5xvf32h/QxekjD5iezP01sM3/eY+p06np3IXw5JhhyhoHtIRfdFvKseP3nURslDWo6EYzgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729454217; c=relaxed/simple;
	bh=xWzDRk1N9eEj3WA1ydBUonj0UZDnv7xX61DBIyGnF4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KIeYYnZaikJ0igPCjJfD1VZIAOKap1AMl9IeeEY4pGRakpGtDRByVMAG5/4T5c9MctlNbrK5AFDoE2uY8lt5TCk/FQGkS4Ly3bqRNC+eJIjE50tybMl+eq/mAbZXNyrSD4aNKf0Eci2sHAFQkqoV92GZN3J4BXxtvDRKOfT+Jbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=Bugkx0uP; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=r+jAwh0p; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="Bugkx0uP";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="r+jAwh0p"
ARC-Seal: i=1; a=rsa-sha256; t=1729454020; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=P30uI57RIj7btkGmmOKvxIv/O8Ep4Bx5UT/8fhhIGaM1cotHRwtS1OmfZ9CpJpDw2r
    lolpB+5YBppZadHb6kBVGHnr8lYju6N1BxxjblDYY9W7pEV7gjqFCbyjYTi2snBhUh2x
    1UwxYfxy5VdBbhfyl2/Udn3BSVQsueRGEmH5MyjRluxCScqhmwnrqWZIbMz0Rmo+oM0q
    HvPp7amP2EdiFluLEhBJgfKVx9dTtSH2KlKfqLSEX5C/SXVYRusgbwi4/TT9PttgWSwl
    AidEDHaM0Cg5V/wmuuKsIJ5hBXjwMhH3oz+XBgW7TLwXFuCwPAJLg08l7zldj+u3aq7o
    MjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729454020;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=xWzDRk1N9eEj3WA1ydBUonj0UZDnv7xX61DBIyGnF4Q=;
    b=cXBjzjAek2rxAG+4i/s51cujDbtk5cFolVGm/ZxuTUb39EXmuUbAWqszMDrSOMYxC/
    Z2RHyuclXtjU0HG4sGyjMZIZ1j8fUUS3ZetmerLbUVciJVSDfBjWEXa9JU+DHdWsT6cM
    wVzBTPzgR7RQFnbrOHIsgdQ7R0mdOSlm1EMBAhKkE+0+UfZ2SAX6vCYT4bSUNEPXozfc
    hJl2cx14aNpU3cmKSzEi7gd0w97WMded1M/rM83GRwlXCVOGqilj/Epcc6SxaKN0tzcX
    SPR7RS0a55BVWz1AJKlC0srKHfK5r+CPThCZ3QfzSrMg4vgw8wQzyYjkrgZEhQByRmTu
    h1AQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729454020;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=xWzDRk1N9eEj3WA1ydBUonj0UZDnv7xX61DBIyGnF4Q=;
    b=Bugkx0uPo3aHw85Ft2Vw6TDL0W5OpZQCB+QntfItubFkmzP2UvbQH7HWeRZnfWbwE0
    0ys0Ns0rYM36fjr8lXiQ82nh86Mx7LBd1kEcD0Tp+B2OfOebsjR2I6yZZ5fzEU9ZycRs
    nfjWW7NU7Besd1foprVH9cw3nvvgIyIRdXg9y5DUWhJlTE8AGACq6EAtihIzIO19PctW
    0xqRgCdZHu8hQnYt8aLKLCiuL27Peb53VO1jDJn4/qxnNg2hP1+54Y9lYHJrbUhPDs9D
    cqSVTBCxD1uQUhRDFXVsw0r8IjvvP0Fw4GgdzIPg0JaWeDUZJGKXP3uSWvtRwx/Xhple
    u11w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729454020;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=xWzDRk1N9eEj3WA1ydBUonj0UZDnv7xX61DBIyGnF4Q=;
    b=r+jAwh0pGSRuy4UbCVNr08dGuHnl2jN0lK3Lf0X+dg7/WSgxDY8lF55f11pxXDxkIz
    f9jYKXWsCzeTCSdi4zCQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0zNriHg+YfT0rGWYpI+wj+spyMYUkXOdVtbeJt47M/LNQin0Lcc="
Received: from p200300c58718678f3e695a7e1d71bbfd.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209KJreINk
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 20 Oct 2024 21:53:40 +0200 (CEST)
Message-ID: <ad22dbd497a5f24390b21066a4accf83d33c1dfc.camel@iokpp.de>
Subject: Re: [RESENT PATCH v3 2/5] mmc-utils: Add FFU mode 2
From: Bean Huo <beanhuo@iokpp.de>
To: Avri Altman <Avri.Altman@wdc.com>, "ulf.hansson@linaro.org"
	 <ulf.hansson@linaro.org>, "vfazio@xes-inc.com" <vfazio@xes-inc.com>, 
	"linux-mmc@vger.kernel.org"
	 <linux-mmc@vger.kernel.org>
Cc: Bean Huo <beanhuo@micron.com>
Date: Sun, 20 Oct 2024 21:53:40 +0200
In-Reply-To: <DM6PR04MB657560CB169629A671BE4D40FC442@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241013210925.123632-1-beanhuo@iokpp.de>
	 <20241013210925.123632-3-beanhuo@iokpp.de>
	 <DM6PR04MB657560CB169629A671BE4D40FC442@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 06:56 +0000, Avri Altman wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (ffu_mode =3D=3D 2) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 set_single_cmd(&multi_cmd->cmds[0],
> > MMC_SET_BLOCK_COUNT,
> > 0, 0, bytes / 512);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 multi_cmd->cmds[0].flags =3D MMC_RSP_SPI_R1 |
> > MMC_RSP_R1 |
> > MMC_CMD_AC;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 set_single_cmd(&multi_cmd->cmds[1],
> > MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf +
> > offset);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +}
> Actually, I was hoping to avoid the "ffu_mode" extra argument.
> So that each do_ffu<x> has its own fluf encapsulation logic.
>=20
> Thanks,
> Avri

Thank you for the suggestion. After reviewing the approach, I believe
it's not feasible to encapsulate the above code logic entirely within
each do_ffu<x> function.

The primary reason is that during the download phase, especially when
multiple loops are required, I need to update certain state variables
dynamically, such as the ffu_mode. This allows for handling the
different stages of the process efficiently across iterations. The
encapsulation logic would prevent us from adjusting these variables
between loops, which is crucial for ensuring the proper progression and
handling of larger data sets.

Without this flexibility, we'd run into issues when the process
requires multiple passes or loops, making it difficult to adjust the
behavior mid-operation.

Let me know if you have any further suggestions, or if you'd like to
discuss alternate solutions.

Kind regards,
Bean
