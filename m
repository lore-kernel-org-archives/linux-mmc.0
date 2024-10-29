Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930691863F;
	Tue, 29 Oct 2024 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730168104; cv=none; b=JfK7fIacx/+nKH8pydeep5mOSDVhbt+Ho7rD4krJNITEzLyrQ2lfrlNYtBiZy4OHY6mk34HYayyM9qoNxYCrJLrb/sXFmQk5uSl9Cfx9V4ZB8lsHPF3JUjL+j8le/6l3ZOqMtHwhwsWuMOsQFCiyC3ZqqkR1EPpJOAqmTH0xxD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730168104; c=relaxed/simple;
	bh=AeXjM+KrtUS2sBUX9RGnVY1PaBn/obbXi2dQOFIuKBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYhL1WrwwhYuFoguTfK3Ox/25mCba5nEzgsDTm3qxx+LovVCeluS+P0WN8vFiu02P+nF87ObAP40ThIfsACwolj7yVf9HFNi9kEqoGINk+x3LuCMe1cDUWI7EKQgOIn10nZkL4l+HM7nfbcBXkEBxWWEF8dp/FywBJeujAfJThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEHYTCJZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEHYTCJZ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9428152c0so5697513a12.1;
        Mon, 28 Oct 2024 19:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730168100; x=1730772900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIiU2u88CNLnMtknaXCkV4tr9hDbgVBg90xo4uhBPuY=;
        b=LEHYTCJZjzPMbo8bJfLLkxfLngu+mgSmevyTPglCxhn759oUOGobqKtwbS+YvqeJfh
         DUEqZ3C4+0OmI/xxALn1pWPIPBAnxdycVG5l9LL+/qxrcLfafZAFtUXf9EFFmV1N2AMW
         FgVDG1cbxVemRXEHS/dUl6FYav2c+3uQ1jgYmb/NovZkBhUJR7dpwz7syGufD4luHJlD
         rLoMZ/ocApdmMuyJgQ3Lu/Apx3swHeV1a73ypzrC3/knSJ37E9mGBnHcqgmMq2vNu3TP
         PySewY/6WCFAaSc7Z9d7KRRGI8umjm5nMerjKaTt7dlQkfQCMkXNMBRyvG7azKDSIU0u
         30qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730168100; x=1730772900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIiU2u88CNLnMtknaXCkV4tr9hDbgVBg90xo4uhBPuY=;
        b=sWeQs/OghHD3juNAikCfF7tXx+j8+qOLG7oUBAQumfbQ/I1zik+TwedG9fchqdO9um
         i0xUC3DLSnt4O3pY4QpaS+VJYzBgjP9bRzurRDFRm/A97CaUJ1oJDZ1v2gUyKfPPdleG
         HS8FcX0g8XFa6x6wqWtGmVwt/osNYPj6yGzqg0+5YIJ/ckUelEpO2Sg1RVQc1N+/9a61
         BLASyj9R49dos1BUp89veqZKt0q8WzRgXqQAgomMSd/raqcu4L6awypKHD6v4kv24KpG
         1heXU2tjwXEbZcGtDkss3w9Kpqvn82DWUE5wEJtU3QYYa4grruE+qKkypMK/k+sYOp8p
         ecYg==
X-Forwarded-Encrypted: i=1; AJvYcCUexo94jJz3X9/vG/P7+pKUhRf/rfcGCx88yo+e/wdd7BLRtqwU3j0wYDfwKNu2OawaepKOQvaDNLEx@vger.kernel.org, AJvYcCVKIYLEmAKqdcnCyMEEUNGs+RdyjEWAgC8N7NzXUAJVjmzEAW5kjgvHJF6SMro3A136X1XRt8/IjGZhBGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWOjLn16lu2GFrrWSn6x3S9ZkNQSiTr5JYYTVoZvpmCO7dBh3r
	iJgkEpVtDeCoJanvnp4KGeM7wE1OS0b0KBQKVsBU4iF1/vn3LqRESUDsmE71G8rsYFkR+uQuFC1
	74d+PEb7WGjlDzIJR2nnFtqgLbF0=
X-Google-Smtp-Source: AGHT+IFbBQvmK+EqMm3U3Vb9kazuFRR5cf6WIpDO2fxv3BVBeloP2e+f8Tuw/Olo8uB7+cWasCGQr5+O8J7uKtK16zI=
X-Received: by 2002:a05:6402:1d55:b0:5ca:ea4:874a with SMTP id
 4fb4d7f45d1cf-5cbbf8c2d7emr8761748a12.14.1730168099608; Mon, 28 Oct 2024
 19:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025060017.1663697-1-benchuanggli@gmail.com>
 <CAPDyKFpb5ZePhXziLH3VbuKKywJZbo8UBF1NM1_dyOWq9oLDng@mail.gmail.com>
 <4dd25dca-f217-4abd-88e8-0a6b03760dd7@tuxedocomputers.com> <CAPDyKFpx=FwMH0PgaQqd+hFVa3ncuUjnikC3vfDHwN9V65H9mA@mail.gmail.com>
In-Reply-To: <CAPDyKFpx=FwMH0PgaQqd+hFVa3ncuUjnikC3vfDHwN9V65H9mA@mail.gmail.com>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Tue, 29 Oct 2024 10:14:25 +0800
Message-ID: <CACT4zj-YT21rFFg=VYk1OF-HEefVYR=d=JXYbUz-kGrj_RD85g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-pci-gli: GL9767: Fix low power mode on the
 set clock function
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>, adrian.hunter@intel.com, 
	victor.shih@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Lucas.Lai@genesyslogic.com.tw, victorshihgli@gmail.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Werner Sembach <wse@tuxedocomputers.com>, cs@tuxedo.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 7:44=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Fri, 25 Oct 2024 at 17:40, Georg Gottleuber <ggo@tuxedocomputers.com> =
wrote:
> >
> > Hello Ben, hello Uffe,
> >
> > thank you for this fix.
> >
> > Am 25.10.24 um 15:22 schrieb Ulf Hansson:
> > > + Georg
> > >
> > > On Fri, 25 Oct 2024 at 08:01, Ben Chuang <benchuanggli@gmail.com> wro=
te:
> > >>
> > >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > >>
> > >> On sdhci_gl9767_set_clock(), the vendor header space(VHS) is read-on=
ly
> > >> after calling gl9767_disable_ssc_pll() and gl9767_set_ssc_pll_205mhz=
().
> > >> So the low power negotiation mode cannot be enabled again.
> > >> Introduce gl9767_set_low_power_negotiation() function to fix it.
> > >>
> > >> The explanation process is as below.
> > >>
> > >> static void sdhci_gl9767_set_clock()
> > >> {
> > >>         ...
> > >>         gl9767_vhs_write();
> > >>         ...
> > >>         value |=3D PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> > >>         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <---=
 (a)
> > >>
> > >>         gl9767_disable_ssc_pll(); <--- (b)
> > >>         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > >>
> > >>         if (clock =3D=3D 0)
> > >>                 return;  <-- (I)
> > >>
> > >>         ...
> > >>         if (clock =3D=3D 200000000 && ios->timing =3D=3D MMC_TIMING_=
UHS_SDR104) {
> > >>                 ...
> > >>                 gl9767_set_ssc_pll_205mhz(); <--- (c)
> > >>         }
> > >>         ...
> > >>         value &=3D ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> > >>         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <-- =
(II)
> > >>         gl9767_vhs_read();
> > >> }
> > >>
> > >> (a) disable low power negotiation mode. When return on (I), the low =
power
> > >> mode is disabled.  After (b) and (c), VHS is read-only, the low powe=
r mode
> > >> cannot be enabled on (II).
> > >>
> > >> Fixes: d2754355512e ("mmc: sdhci-pci-gli: Set SDR104's clock to 205M=
Hz and enable SSC for GL9767")
> > >
> > > Is this the same problem as being reported in
> > > https://lore.kernel.org/all/41c1c88a-b2c9-4c05-863a-467785027f49@tuxe=
docomputers.com/
> > >
> > > ?
> >
> > Yes, this patch fixes
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219284
> >
> > This makes my patch obsolete.
>
> Thanks to both of you for helping out and fixing the problem!
>
> I added Georg's reported/tested-by tag when applying and queued this
> up as a fix with a stable tag.
>
> Kind regards
> Uffe

Hi Georg and Uffe,

The original test reported on bugzilla that only Intel laptops had issues.
AMD laptops without this patch seem to have no impact.

I'm not sure if this patch is related to the originally reported issue.
Thanks for the help.

Best regards,
Ben Chuang
