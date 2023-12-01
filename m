Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDbTERif"
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ACC10D0
	for <linux-mmc@vger.kernel.org>; Fri,  1 Dec 2023 05:18:42 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d41657b7a5so6363977b3.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Dec 2023 05:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701436722; x=1702041522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09w7LW+cnqnlOMOkAO+xvtNckElk6wbrltpRZF7gZK8=;
        b=jDbTERifj0EHk24e+bi818C0wkQpVbzuqsDVyzmn9V5jii+a5mYb0kUBmzkNtJTcIQ
         5PBIQ0svSwnML2LGV5uiAD9Oj2Pgy9jzOM8k9YsEuFK7NfwK8iQggQg3lXkf7JYGRIfd
         aVYsZG0tbWukeHJp6bCWo8azR7y+C8JqIaay6cDE2LDBNdUJkMW4egClcRb6MRkGDf+w
         n7owctiCTjqOG0Zz8F3ChBQu5QwZ5ZmfPodF7Cem+VXB1JHZWSGy84U9/H1SEztF4h9h
         dedISDAxoxEmmg1ogvBCo5Z3vXbxw6PdeQoBPkU/zC/I6MIOwvf7UFBK7nKoVw97rVHy
         WLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701436722; x=1702041522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09w7LW+cnqnlOMOkAO+xvtNckElk6wbrltpRZF7gZK8=;
        b=ZFnsTiQ796unyzU5nGXcZFYOJxoByLpe1jqvj6Bzn9m2OmP2Zt6zjagXyjIX8KplU1
         9XAkRWbFGw/FIXkv0c2qaJUig0Cg6+FiBTTS9h7APDmwrnHt/TrzHOD4Ox1WalF08Hbo
         qAFiHk0eoENqoLXr9QA8Vg+STtvj1jEPwqDOq9aC2qFHdTvbr+35NBgiMMdD3fK+lrit
         PDWaCb9mSX1jIUcMfHFatncPr7VmVml/vRR8Xu46WPe0ySt3uho6XKQFE0lBAulM/kE0
         QXDUNju68h2bvrvX7l0wDrjyfPKbqmkplVWaCAOPoDcVWMALFvdoTJ3fVeQoO2hoeCF7
         +E3g==
X-Gm-Message-State: AOJu0Ywx6KY/Rdg3cNm7a6zcYq8Lc5x5Z/Pfwn0aXJxWUW+8tnzLf2te
	G06bicz3lIzXbQyLB2QklnbO+rKuhdtqNpjfdMkzkA==
X-Google-Smtp-Source: AGHT+IED9fUj04DIXgJcAJDTj+imzR+T7qCQhh61mUs0nVQkvTLJCffTbDrbVbGT9xP07igPg64irBBooCwy4hbwxiw=
X-Received: by 2002:a81:5743:0:b0:5d3:ba32:a10b with SMTP id
 l64-20020a815743000000b005d3ba32a10bmr3341733ywb.10.1701436721755; Fri, 01
 Dec 2023 05:18:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201091034.936441-1-jorge@foundries.io> <CACRpkdaMnphBxvqpmvNG_72O02Umny3qdxfyrKdA4BsDwZmtfg@mail.gmail.com>
 <ZWmptatt60if9GBH@trax> <CAJ1nHOW9T3yvFj5FFdOZYrdgfy0f=opiDri+2srE=yBp5vtVZw@mail.gmail.com>
In-Reply-To: <CAJ1nHOW9T3yvFj5FFdOZYrdgfy0f=opiDri+2srE=yBp5vtVZw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 1 Dec 2023 14:18:29 +0100
Message-ID: <CACRpkdZHB4OETge9T6g5zHqMdd=uO3_-jbMMmzf+vRn=fJQHiQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: rpmb: fixes pause retune on all RPMB partitions.
To: Jorge Ramirez <jorge@foundries.io>
Cc: ulf.hansson@linaro.org, CLoehle@hyperstone.com, adrian.hunter@intel.com, 
	jinpu.wang@ionos.com, hare@suse.de, beanhuo@micron.com, asuk4.q@gmail.com, 
	yangyingliang@huawei.com, yibin.ding@unisoc.com, 
	victor.shih@genesyslogic.com.tw, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 10:47=E2=80=AFAM Jorge Ramirez <jorge@foundries.io> =
wrote:
> On Fri, Dec 1, 2023 at 10:39=E2=80=AFAM Jorge Ramirez-Ortiz, Foundries <j=
orge@foundries.io> wrote:
>> On 01/12/23 10:28:52, Linus Walleij wrote:

>> > > +       const unsigned int mask =3D EXT_CSD_PART_CONFIG_ACC_RPMB;
>> > >         int ret =3D 0;
>> > >
>> > > -       if (part_type =3D=3D EXT_CSD_PART_CONFIG_ACC_RPMB) {
>> > > +       if (part_type & mask =3D=3D mask) {
>> >
>> > That looks complex, can't we just:
>> >
>> > if (part_type & EXT_CSD_PART_CONFIG_ACC_RPMB)?
>>
>>
>> I chose to mention the mask nature of the field for clarity - just in
>> case - but I'd much rather do your suggestion. So will do :)
>
>
> sorry no, I mispoke  (I like clean code so yours looked neat)
> we have to compare against EXT_CSD_PART_CONFIG_ACC_RPMB
> bitfield since part_type could be EXT_CSD_PART_CONFIG_ACC_BOOT0 (0x1)
> in which case we have to skip it.

Aha those defines are not flags but enumerators. I get it.

Yours,
Linus Walleij
