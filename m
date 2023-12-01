Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgJ+49/0"
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4464F469D
	for <linux-mmc@vger.kernel.org>; Fri,  1 Dec 2023 01:29:06 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d3687a6574so16359177b3.2
        for <linux-mmc@vger.kernel.org>; Fri, 01 Dec 2023 01:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701422945; x=1702027745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMJWPTMz3I601PDaKg2G9zUK8oGX7I/FmdndTXV+PEQ=;
        b=cgJ+49/0UbaSjAIUhmS5SocHDBx5KjVQSIBtJrMHoKlfni5Q76uujUzQBPpBqh2pgz
         CLhspyrejyhIj5Jnih4hoDikQ+kOaHTF2sXwGXboSVwdLQ7vEtHuWgtC0aW64a7Ybnw6
         yZbmjKQcq4ZG5a329c7iubSwnUzjNz0f3T8vSjigMUp/j75uiF5k72ICj3OdagoPbhwj
         UDe3VaURzy7E1ZJORcfnF6mM0CQBisKEIfyKNCe8zfRamQTL0dVgBvtHH7BinhaVAdtu
         j0Ll7MhKQ5q3P7pYpRPUtbkq61hWzlqD64979xH6O3lRDodkChzRht7JURyaSAtfVPZj
         h7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701422945; x=1702027745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMJWPTMz3I601PDaKg2G9zUK8oGX7I/FmdndTXV+PEQ=;
        b=FlVVr18W4pni8QnuAbZBM6xoV4nGhMNfvfLAfImg+nsBdhGthFPxjXoTPK+Tvgbutw
         4x5RQE5q460Hnxji4BlJUnpvlf8p0Q4LI/Z+ziNMuVYKvV+RmJjbZ1DFnCGBYvzeVsTY
         fXnC/J7rJO1VwhDuEhbHdfSgi2dQ1T41CCMuN/edKjmvYvmSzOaL631J83djdnQJnueU
         B89vI2Y5hn2L/rtRNPwjlNhdFeO62qZougXW6yIiAVmu6usQymtaZzpXLSXnOz/BLLMC
         ioIDcT9spTSaR/3v8L7CNuHRXHsnXTsbaQSLuxv3JgVzhcKCoSLvspR+SsRo+Ulaugwv
         KnjA==
X-Gm-Message-State: AOJu0Yy1BMExEhJTKuFGQnAuOg0FkxTKtzZUSBYCeD+ncQ0GPzV8WZh8
	klW2y/+eCBs42ygqiF0sC7L0cSXTEMq289lDxsfxJg==
X-Google-Smtp-Source: AGHT+IH7z5fSeuufF5Cxad9UDRaE+shZZJy1gQvx2kCB4e/jW1K7Fe5gWDdyHCZzHgjNd7epaL2M0znaAmC6vZYwWYo=
X-Received: by 2002:a81:ae59:0:b0:5d4:313c:4b07 with SMTP id
 g25-20020a81ae59000000b005d4313c4b07mr937537ywk.23.1701422945075; Fri, 01 Dec
 2023 01:29:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201091034.936441-1-jorge@foundries.io>
In-Reply-To: <20231201091034.936441-1-jorge@foundries.io>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 1 Dec 2023 10:28:52 +0100
Message-ID: <CACRpkdaMnphBxvqpmvNG_72O02Umny3qdxfyrKdA4BsDwZmtfg@mail.gmail.com>
Subject: Re: [PATCH] mmc: rpmb: fixes pause retune on all RPMB partitions.
To: Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc: ulf.hansson@linaro.org, CLoehle@hyperstone.com, adrian.hunter@intel.com, 
	jinpu.wang@ionos.com, hare@suse.de, beanhuo@micron.com, asuk4.q@gmail.com, 
	yangyingliang@huawei.com, yibin.ding@unisoc.com, 
	victor.shih@genesyslogic.com.tw, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jorge,

thanks for your patch!

On Fri, Dec 1, 2023 at 10:10=E2=80=AFAM Jorge Ramirez-Ortiz <jorge@foundrie=
s.io> wrote:

> When RPMB was converted to a character device, it added support for
> multiple RPMB partitions (Commit 97548575bef3 ("mmc: block: Convert RPMB
> to a character device").
>
> One of the changes in this commit was transforming the variable
> target_part defined in __mmc_blk_ioctl_cmd into a bitmask.
>
> This inadvertedly regressed the validation check done in
> mmc_blk_part_switch_pre() and mmc_blk_part_switch_post().
>
> This commit fixes that regression.
>
> Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>

My bug :/
Shouldn't we also add Cc: stable@vger.kernel.org?


> +       const unsigned int mask =3D EXT_CSD_PART_CONFIG_ACC_RPMB;
>         int ret =3D 0;
>
> -       if (part_type =3D=3D EXT_CSD_PART_CONFIG_ACC_RPMB) {
> +       if (part_type & mask =3D=3D mask) {

That looks complex, can't we just:

if (part_type & EXT_CSD_PART_CONFIG_ACC_RPMB)?

> +       const unsigned int mask =3D EXT_CSD_PART_CONFIG_ACC_RPMB;
>         int ret =3D 0;
>
> -       if (part_type =3D=3D EXT_CSD_PART_CONFIG_ACC_RPMB) {
> +       if (part_type & mask =3D=3D mask) {

Dito here.

Yours,
Linus Walleij
