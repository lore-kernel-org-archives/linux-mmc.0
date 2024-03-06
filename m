Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EAE137915
	for <linux-mmc@vger.kernel.org>; Wed,  6 Mar 2024 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740625; cv=none; b=LCXDdmkvUBi72JlQfwlcx7/z7xt7XysyJwZGivQqerYuyfI7sF3LG+mZt75aZVbZbNvdIPnvFPTLayEzWjW3ytHOLjn/OEFGFafGs3MxoCqJShnj/CWx7BI9VkUAAHL+Hu8cJW6x5O66B1jWw5BfRrlEaAwVM6Gzg1YanxWXm3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740625; c=relaxed/simple;
	bh=y1KNSY2klj9TyNv0mKj+D0MKiuhGSXTO5BHMy1t7fH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJMX7hp1ObHJjBP/2DYkEJu7ziLBYyppR3YQ+jwqMTrRwjX0pf1XeCiMQyepmZkzNEoCtMy4mVlNnduiw0p4LPMw98zWS/8OHJc1pNhRQugt6r8qwTqQ2TTOocj9g8pZN6AOWOmEhI7oE6zQI4D1x96GFHKWDhlseI3T7BAAcAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G+9JnmEF; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+9JnmEF"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso804291276.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 Mar 2024 07:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709740623; x=1710345423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2f+5aPU/XdbNCp1ggYwNVgQ5AaKBkNmvjYLVF7eMmS8=;
        b=G+9JnmEFomgLSXSdnMmXKue6XtwdWTMZFLJDq62dzc4zs0lo6Ee2KwAFQQCz/Ga23o
         QCQpNBVDawtZDlD3hZTeFCR0hcmn6liXnD8yTfQKFB5RNCA6u2DNfgguYOmD3NA15rOa
         K87ivmidMac+if65s7GvP8GOWsFeIxBeew02QlL4A1Kbs+YjDxhNf/2J7RwUGDNTHUoJ
         nQH3eXGailZepNEgGqP0Rmxn/BTbtfw/heGmle7/GA2ZpVm05fT1lqEWfiIlwS+itICi
         7DpYNyXiVQBW3FM8FzHAT6uu1DBgC9n7Y012oL6okeVHwEYOUlX9sb6m+iGn+xF7I9II
         j91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740623; x=1710345423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2f+5aPU/XdbNCp1ggYwNVgQ5AaKBkNmvjYLVF7eMmS8=;
        b=nffTqIMWBeKNbcnT/hEFoTxAk99hhcoVl4lWR6185KGEUs7eAL3eyiXpj2gXz2oJck
         1AKH9RDHP22lR1VZyh3uBdsysPmeeN17/LJEb6+LAEcX63GEX5y/85c8gpeEHinusDQO
         Yj7i8tPMVHs/Xhx2XlHxwWaeZX7JOcUvhG/vhHNG497TEnaJedTkC0MDccmyqv1ry3aV
         mghQs8L/xOspLGLonBEJqOX1cJm2VxFwctImYtUxQdD8GuMtJNCkFhOVjfZZS6uvCV6S
         Xb3i0+13zGX6fsVgbDPs+oZWvXimENv109pfSbWI/3yT6F13gcsmUynvEGeWvezlua6s
         zWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5o6Unml8ux55iTyB0Kqz+1u4ZusivySiGIJleuH42nJfUZPlfdr/Oh6PIgtiDhNVmvuNM5vnAsMbNwFGPMtjs4CMZLcGs1OP9
X-Gm-Message-State: AOJu0YyWY3V9WaMtggjH5PU0mBiszeIXdQiy7dWD3JMwlp8k0Ara+Ihz
	rdiIuWhpvl4yZjx+PxGDdGD4fxWVnhGVM1JZMuW0I9fUhWMEK4N1Osbkp8yg5eBmzH2RK7ya2t/
	88jNkBy/79rHAclAyoX1ZKGUtj3xrqFid88QdRQ==
X-Google-Smtp-Source: AGHT+IEiBAntuAC1iQgfrTxPAdJ0FUKBL/8fqeqAZ/6SuiKB3vWu9Qa4XggVFqJogNCxgNIqcJZDkJj8OmAWXl+Vt8g=
X-Received: by 2002:a25:6b09:0:b0:dcd:24b6:1aee with SMTP id
 g9-20020a256b09000000b00dcd24b61aeemr10930675ybc.47.1709740622702; Wed, 06
 Mar 2024 07:57:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
 <Zegx5PCtg6hs8zyp@trax> <CACRpkdYZrDgVVCp2bqJqY1BpeHSXDWbRSqk6d=N_QhC4OVv=Ew@mail.gmail.com>
 <Zeh8HGDToMoHglD2@trax> <CACRpkdZ1ervTXj6++oBPDNJT3TpVgPeYsyhaEMRYavJQ5iZPqg@mail.gmail.com>
In-Reply-To: <CACRpkdZ1ervTXj6++oBPDNJT3TpVgPeYsyhaEMRYavJQ5iZPqg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 6 Mar 2024 16:56:26 +0100
Message-ID: <CAPDyKFqYDPgNjSkpH=XATkUY2XtjsaDstChcAnGxoas4jgDVfw@mail.gmail.com>
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Tomas Winkler <tomas.winkler@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Mar 2024 at 15:38, Linus Walleij <linus.walleij@linaro.org> wrote=
:
>
> On Wed, Mar 6, 2024 at 3:22=E2=80=AFPM Jorge Ramirez-Ortiz, Foundries
> <jorge@foundries.io> wrote:
>
> > I still cant grasp how "target_part =3D idata->rpmb->part_index" is
> > helping in the design.
> >
> > What happens when:
> > 1) EXT_CSD_PART_CONFIG_ACC_MASK > part_index > EXT_CSD_PART_CONFIG_ACC_=
RPMB
> > target_part now could be indicating a GP instead of an RPMB leading to =
failures.
> >
> > 2) part_index <=3D EXT_CSD_PART_CONFIG_ACC_RPMB
> > loses the part_index value .
> >
> > So part_index should be larger than EXT_CSD_PART_CONFIG_ACC_MASK even
> > though the comment indicates it starts at 0?
> >
> > /**
> >  * struct mmc_rpmb_data - special RPMB device type for these areas
> >  * @dev: the device for the RPMB area
> >  * @chrdev: character device for the RPMB area
> >  * @id: unique device ID number
> >  * @part_index: partition index (0 on first)    <---------------------
> >  * @md: parent MMC block device
> >  * @node: list item, so we can put this device on a list
> >  */
> > struct mmc_rpmb_data {
> >         struct device dev;
> >         struct cdev chrdev;
> >         int id;
> >
> > is it just possible that "target_part =3D idata->rpmb->part_index" just
> > needs to be shifted to avoid issues?
> >
> > I think the fix to the regression I introduced could perhaps address
> > this as well.
>
> I have no clue how the regression happened really ... heh.
>
> We should probably rename it part_cfg because that is what we
> store in it, it's assigned from card->part[idx].part_cfg.
>
> Then the id field in mmc_rpmb_data should be deleted along
> with all the IDA counter code etc and the partition name hardcoded
> to be "0" as there will never be anything else.

Seems reasonable to me. Are you thinking of sending a cleanup patch on
top of $subject patch?

Kind regards
Uffe
