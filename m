Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1118228030E
	for <linux-mmc@vger.kernel.org>; Wed, 14 May 2025 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747247196; cv=none; b=n8OY16ZAOGOT6HqVNRsaga6NJTI3atG89CbU7R33xAhAL3111bF//bQfzcMVL4ToA9mjzz4d+WXomBxQch4CTuhJtJEEuLvcVgBaZgtDt3QqNkvRdHOqKiCDBJDAznyZYaKKbYi4/i8i4UXLfq1LmtJUqRy1lxEteVOXdOOIF2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747247196; c=relaxed/simple;
	bh=ANgO1hKvlB56oJF7H73XtrDpnhVSl3zyWEHbVgw86y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyaJjEHa9lrYgLR2JCB6BrNG+vNrAeyvp5PyLZYQFm57DuHEWtlA454e9aZZIcUjvRTHiIgNcDVYTT7mib67YCbmsjwuLnyjdduImJGYRqAvjw3MdB528DJBEeYkpjso36Pmfw1EIpARVyqnHuKIZrm+4llyDyRZsOqOOVHfj/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfOZAGia; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfOZAGia"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7418e182864so193433b3a.1
        for <linux-mmc@vger.kernel.org>; Wed, 14 May 2025 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747247194; x=1747851994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANgO1hKvlB56oJF7H73XtrDpnhVSl3zyWEHbVgw86y0=;
        b=mfOZAGiazI8mlZiITTv+mF/234A1ysltzk6sy4ZbJOusvXgPVMR0OBODuotUof1dD6
         e/oFjlbmRc3OyB0z2HVbVbnMlxZZWKxvb0j7T1VrPjIS4Yev3C+VjYdYhTa+Es7mE/27
         mfwzZaIRJ4OhTK4Z9Ff3DTYdWIjYG5+XXxPhKePctDFWnCEP4jfQiGj+psYHpOo2ghJ1
         gCZSeLeVkTKbMjuikzH7cbuAEUD5TYkQ0UPwOLQdiiJ+1iEQGvfbVTpQP3lIdkbNsslz
         3IgW6eddPogj+uiITp0y5AsvblkeEq2+oZ9IvjfaFzDp2GXqN3CpH8GTQ91DL3l2sg0m
         L91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747247194; x=1747851994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANgO1hKvlB56oJF7H73XtrDpnhVSl3zyWEHbVgw86y0=;
        b=UoGDsu8BNDP+Yd8h84BLJ6CRoLXoQB8qzcLbzyDiZuDZg+ltR1Vd6Z2yGxZX394M4F
         zQ2lEv30VKD3qJMZQgoYTekg+SWh/PuNHcvxGYbBgO4Ui6l9iwAxhuyz65PMnTj5qSUx
         k7wzcAJGAIDhnOqeDfl0V+etPEpKBO0FiiLRh4dranbdrVXXSNd+6EAkoj9TdK+voc1u
         OiGEyZrVSjOHIPTRwUvUMpgTvti6uCQMDmDyVYbcrD9DLqYQ6U69wtnHCPydtG8w+sbJ
         MlojP0xGs34aF+hz2TaDc0Cvg0woOAxHQdLvPvp49MbK5wwonG5yNPhYCxj1gJ1nKfXY
         gBSw==
X-Forwarded-Encrypted: i=1; AJvYcCXL7iPceIHnijvuiW5kah2D+CuBZ9BlGaNnNTPUeMFEdcxz3jojAw5b8U7v0jj2I+3yA51eWIl/qPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwWGJQZDj5Cr8N1TRn+X7ho+gcS8ddvMawQpsJz95DcC0AjKoh
	tkAfjP5AHqm2knyG/Rm8PeLXSjgndkX55wdcoqsTjzkusK+kK0dMqBuZ5MhEpOeGvVZLLpwCiLB
	wQRmHRJ7pjuHfpc9JUUvueH2/1EzVcjUi
X-Gm-Gg: ASbGncti8jJocx8NljIHZ+u18X/cY1KqMElXSK9fAO80RT8j/wNnfNXwUPy/I1XQKoh
	x44btaveBWxe7VTWrxewDoMKkDy07BUd2qyWIzKsuCL58n0Exjq8AhRmWteSYLNeTXHG5A0++UQ
	hdY4W2msgpYKSBH5EOJScgymAWbN7tww==
X-Google-Smtp-Source: AGHT+IEEZiff/RnANP282wSBsSVA8alwgoQ7QXOvLPcJikCOmDzN8Dk8cJY11ArU00sjNDudqRJDJzpZW/Pj1L50bOo=
X-Received: by 2002:a17:903:f86:b0:224:11fc:40c0 with SMTP id
 d9443c01a7336-231980cbea5mr65163535ad.11.1747247194041; Wed, 14 May 2025
 11:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJs94Ebmyf_5BWNvSRa2O+3oEcwnYFN4Zs-BP5_fPqxQsxKvzw@mail.gmail.com>
 <CAPDyKFo-NDg74vVEk_jU6T8vXqigVzhYuVNYjqJ=Ye9nnjE67Q@mail.gmail.com> <44f8111b468d4f438991d04d951dc06d@realtek.com>
In-Reply-To: <44f8111b468d4f438991d04d951dc06d@realtek.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Wed, 14 May 2025 21:26:22 +0300
X-Gm-Features: AX0GCFuQCmqS3cTl7WgbF-1LkLjzthp4UVfDjXkcktRc8qGHU1YKQ7o0ygzJaJA
Message-ID: <CAJs94EazC1uN+D41Ykih5tioD5F9f+wjWkz-kdSHxuM-NbM9NA@mail.gmail.com>
Subject: Re: mmc_test framework: failures at rtsx_usb
To: Ricky WU <ricky_wu@realtek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 14 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 06:25, Rick=
y WU <ricky_wu@realtek.com>:
>
> > On Mon, 5 May 2025 at 20:56, Matwey V. Kornilov
> > <matwey.kornilov@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > >
> > > I've just run mmc_test suite on rtsx_usb mmc host controller module
> > > with RTS5170 hardware attached.
> > > Kernel version is 6.14.0. The following four test has been failed:
> > >
> > > May 05 21:06:47 localhost.localdomain kernel: mmc0: Test case 15.
> > > Proper xfer_size at write (start failure)...
> > > May 05 21:06:47 localhost.localdomain kernel: mmc0: Result: FAILED Ma=
y
> > > 05 21:06:47 localhost.localdomain kernel: mmc0: Test case 16.
> > > Proper xfer_size at read (start failure)...
> > > May 05 21:06:57 localhost.localdomain kernel: mmc0: Result: FAILED Ma=
y
> > > 05 21:06:57 localhost.localdomain kernel: mmc0: Test case 17.
> > > Proper xfer_size at write (midway failure)...
> > > May 05 21:06:57 localhost.localdomain kernel: mmc0: Result: FAILED Ma=
y
> > > 05 21:06:57 localhost.localdomain kernel: mmc0: Test case 18.
> > > Proper xfer_size at read (midway failure)...
> > > May 05 21:07:08 localhost.localdomain kernel: mmc0: Result: FAILED
> > >
> > > Should I normally report it or it is known not to work?
> > >
>
> Hi Matwey,
>
> I have not used the mmc_test suite before.
> Could you provide me with your experimental procedure and steps?
>
> Ricky
>

Hi,

I did as described in the documentation. First, the kernel was rebuilt
with CONFIG_MMC_TEST=3Dm. I run this kernel in a KVM based virtual
machine with the USB device passed through inside. Then I attached an
microSD card (attention: the data will be lost, so this should be card
for testing) and did some magic:

modprobe mmc_test
echo 'mmc0:1234' > /sys/bus/mmc/drivers/mmcblk/unbind
echo 'mmc0:1234' > /sys/bus/mmc/drivers/mmc_test/bind
echo 0 > /sys/kernel/debug/mmc0/mmc0:1234/test

The latter means to run all the tests. The results are located in dmesg.

> >
> > I have looped in Ricky Wu from Realtek, let's see if he has some commen=
ts to
> > this.
> >
> > I personally haven't used mmc_test for rtsx_usb, so I can't tell if the=
se are real
> > problems.
> >
> > Kind regards
> > Uffe



--=20
With best regards,
Matwey V. Kornilov
