Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C14194C67
	for <linux-mmc@vger.kernel.org>; Sun, 20 Oct 2024 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729456584; cv=pass; b=BMlKvAPI+d20k5kC35qRl/dUcqFEs2rEdvkIRUXoZ3LdSKdO1qej5O81oY/bNHXA/IwuBs5YLMJi8BCJo4tYkTCCYP/t5HSf5uw1/7g0omJJyVYeIwm/vjoTc+XOPVVNt53eClmx9BgWEzYTp5l+du4yGoXQ536d+TV6Ob+DEu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729456584; c=relaxed/simple;
	bh=zpYyRw3AkANzVQVVgXur+ZnU5wZkNgNrdD6YPHHLt5A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L0O+A+xy0qFBbObEi1BUGXb/Ros8tADmqu2JfRoOK4mWDIru3Z0AeEqMFN8obbBpaIEZuRCK4xOFnkv0enLlj/7rwdWGkywNXhl02KeZlAGDa+Vy9O7pl26RzMKIVNI9f4GVsfeAPg5NUwM0ex4AdRBIqhnRhTOOhkZhTKtXP90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=Qv+DHY7c; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=Sc05zkQT; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="Qv+DHY7c";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="Sc05zkQT"
ARC-Seal: i=1; a=rsa-sha256; t=1729456210; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=f1OZr+aNLYxMScaqbDojcKtbgx8q0/iBJHR6lyxLiei/fMCCl7GMBmihsbdlmv3Yqh
    Wj0Zmd476+2bWf+2ORMdmoH7Cz1Wdv/1pT1rDmRArNLdj/qNF+01aowl0ga5/aacuFHs
    +gQjpas7XhSM1GtoD+j+6Jy3GD/6LvV9kktVQaULfkAfGLjNFyIkXjOrIxksWi0ud5EN
    /KTfYMQQN/hMxRNwyOoWU8vV+VFcIEjY5+2Jy6vPhEkKloq+FI4JMGL+UuPHGMUPNNwf
    NTqQNRXoREBbVGTCIDDYdPj+//I4R4i+eJjz1LDEtfqNOt2GOl6dQoO2CrIp08Lvym/A
    44fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729456210;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zpYyRw3AkANzVQVVgXur+ZnU5wZkNgNrdD6YPHHLt5A=;
    b=Ds16TVAulfDCkZbVNaPda0Y+VNba96IpVVARFkO2R7uGdOJORJ0R5FImFCr2nv7G30
    6Ysq7boEujI/YnyxA/BmduEhrlf1CmXCVOmGSpOCvc+XQ5bchge4LeeHLqOjK9SRtyDN
    gWGHXRB5I3XUuq3s7awHHxxMwVo8Wld3BocwGqr7j3p5220BkdqT+ygt9NNJBzDhuPja
    +WW3s5gU+AqCY3VmC9pIsOdtGeWEkDbvhU18HFceK/wF+dhbE54k1UAfnnB/aKGokUPI
    C49rpisSA3H4BzcYzh2ycoygIwEfjSFT30cIeXGmBqvKQlCYwsES2NwUZuiV9YdPZsUr
    Oe1w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729456210;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zpYyRw3AkANzVQVVgXur+ZnU5wZkNgNrdD6YPHHLt5A=;
    b=Qv+DHY7cP88yewuNOel0wdnfU674q4/Vo/YVRSdcwoTbVgG7X5BAopEor1V78s9tzF
    jfsgQDneUEVLIIKVY9achfwFLvDqAZczKZcsjMYEfk24Ea6TV8q7Dld25lSwFs3OD9Wl
    hxq4MT1E398gwrXjX59pVa1d1ruwzonYhDEmP2n9A6D9yOTAqNiarErua1JlygLPyJPw
    6wDRAt6344xxJ5Rbac8eKaTcKybzbO1wl2pL4CKaBC1arLzjCDB2/QuOJ6egC+n2fmms
    BIZPrRpbuQjBZ9cYccHww8vCw2M13q+hFtu2Qr3nVxzCFEBu0nj7f7/2UnPYQXkxkft5
    J/Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729456210;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zpYyRw3AkANzVQVVgXur+ZnU5wZkNgNrdD6YPHHLt5A=;
    b=Sc05zkQTkoLMwhq3PUf/RSSyljn68tV87jXMnbDbN6oXytYv//FWXdKuTW0udcO04Q
    qWKh8hwFmHelMeQtdMDQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0zNriHg+YfT0rGWYpI+wj+spyMYUkXOdVtbeJt47M/LNQin0Lcc="
Received: from p200300c58718678f3e695a7e1d71bbfd.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209KKU9IPo
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 20 Oct 2024 22:30:09 +0200 (CEST)
Message-ID: <3d418d89c5d4f420ecf7ea2a15e391a189774386.camel@iokpp.de>
Subject: Re: [RESENT PATCH v3 1/5] mmc-utils: Refactor common FFU code into
 functions to support additional FFU modes
From: Bean Huo <beanhuo@iokpp.de>
To: Avri Altman <Avri.Altman@wdc.com>, "ulf.hansson@linaro.org"
	 <ulf.hansson@linaro.org>, "vfazio@xes-inc.com" <vfazio@xes-inc.com>, 
	"linux-mmc@vger.kernel.org"
	 <linux-mmc@vger.kernel.org>
Cc: Bean Huo <beanhuo@micron.com>
Date: Sun, 20 Oct 2024 22:30:09 +0200
In-Reply-To: <DM6PR04MB657548AECCE954C3FCE9DEBDFC442@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241013210925.123632-1-beanhuo@iokpp.de>
	 <20241013210925.123632-2-beanhuo@iokpp.de>
	 <DM6PR04MB657548AECCE954C3FCE9DEBDFC442@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 06:55 +0000, Avri Altman wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 num_of_cmds =3D 4;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 off_t bytes_left, off;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int bytes_per_loop, sect=
_done, retry =3D 3;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mmc_ioc_multi_cmd *multi_c=
md =3D NULL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dev_fd || !fw_buf || !ext_cs=
d) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fprintf(stderr, "unexpected NULL pointer\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* allocate maximum required */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multi_cmd =3D calloc(1, sizeof(st=
ruct mmc_ioc_multi_cmd) +
> > num_of_cmds * sizeof(struct mmc_ioc_cmd));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!multi_cmd) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 perror("failed to allocate memory");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -ENOMEM;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> I was expecting that do_ffu_download will be called with struct
> mmc_ioc_multi_cmd *multi_cmd argument as well.
> That each ffu<x> mode fills it according to its own logic.
> This you won't be needing that ffu_mode additional parameter.

I wanted to clarify why the ffu_mode parameter is necessary during the
download phase. By extracting the logic into a common approach and
using ffu_mode to dynamically update the multi_cmd structure across
iterations per ffu-mode, I can handle the variations between different
FFU modes more effectively. This allows me to extract more common code
and avoid duplication, as the ffu_mode helps determine which specific
updates or adjustments need to be made to the multi_cmd at each stage.

Without this, it would be difficult to manage multiple loops or
iterations of the download process, especially when the command
structure needs to be modified in different ways depending on the mode.
The use of ffu_mode centralizes this control, making the code cleaner
and more maintainable.

Kind regards,=20
Bean
