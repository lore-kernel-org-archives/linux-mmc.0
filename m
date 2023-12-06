Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF97718D;
	Wed,  6 Dec 2023 00:27:50 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5d3758fdd2eso65829367b3.0;
        Wed, 06 Dec 2023 00:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701851270; x=1702456070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J96bjVl10/YZKpO0+pJdZW7wN1/H6wsxpMA2dwhuCto=;
        b=XAynB3JCLszm0lxVYNuTjTlEcATT/a2lKcjWUIHgSh2fSrA1SLp6ZsCwPOqktu21Py
         R78ahdnOX10qTPaB5LAZDlo4VQsvs6zwRCMVkSxb0BZoS6f8uyPZLShWImdPXEQDtzu3
         zlWPzrw33NohyAWiRFxfHkYB8HlEkJoCMD8qu0DEuGG2ERMwVvYV0oUak7YP/bZkykxV
         Y/LWEhJbbC64Nle/BVyJb4L8KmMdMgI2hpRym3/5Hx8vaLFta1SIZTIXfJVoYQm4qAvZ
         cVmiNdwVBugOZqpF8sa5zHHGn3z0Ea6/vHAEdf+dWKXfeVZoT7N8JVmvnBVsQl8bDMmi
         +5/g==
X-Gm-Message-State: AOJu0YyXNilsgdZZY08iKrxGrJTBcuH8E5cYffJUqJCfIdp4RhOFzY8H
	7RUsX9zPIPcudFBUnLIn2lSS9RPQy3C7EA==
X-Google-Smtp-Source: AGHT+IHneFXRyXNRh2NBYGczFKqTsBrNrAOitW0M+o6QtQRxQ7aPsb+SxUOQZjh/m2xW36UHO2qnEg==
X-Received: by 2002:a0d:eb0d:0:b0:5d7:1941:3576 with SMTP id u13-20020a0deb0d000000b005d719413576mr457636ywe.93.1701851269662;
        Wed, 06 Dec 2023 00:27:49 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id c6-20020a814e06000000b005d364adb887sm4689374ywb.26.2023.12.06.00.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 00:27:49 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-da077db5145so4339070276.0;
        Wed, 06 Dec 2023 00:27:48 -0800 (PST)
X-Received: by 2002:a25:6607:0:b0:db7:dad0:76ac with SMTP id
 a7-20020a256607000000b00db7dad076acmr407887ybc.72.1701851268359; Wed, 06 Dec
 2023 00:27:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206073712.17776-1-jirislaby@kernel.org> <20231206073712.17776-5-jirislaby@kernel.org>
In-Reply-To: <20231206073712.17776-5-jirislaby@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Dec 2023 09:27:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU4_==x7efMMOmxm3L4vZeWGeeWNo2bQ8Pv1wWx7246gQ@mail.gmail.com>
Message-ID: <CAMuHMdU4_==x7efMMOmxm3L4vZeWGeeWNo2bQ8Pv1wWx7246gQ@mail.gmail.com>
Subject: Re: [PATCH 04/27] tty: make tty_operations::send_xchar accept u8 char
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Karsten Keil <isdn@linux-pingi.de>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC linux-m68k

On Wed, Dec 6, 2023 at 8:37=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kernel.=
org> wrote:
> tty_operations::send_xchar is one of the last users of 'char' type for
> characters in the tty layer. Convert it to u8 now.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

>  drivers/tty/amiserial.c          | 2 +-

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -811,7 +811,7 @@ static void rs_flush_buffer(struct tty_struct *tty)
>   * This function is used to send a high-priority XON/XOFF character to
>   * the device
>   */
> -static void rs_send_xchar(struct tty_struct *tty, char ch)
> +static void rs_send_xchar(struct tty_struct *tty, u8 ch)
>  {
>         struct serial_state *info =3D tty->driver_data;
>          unsigned long flags;

Looks like this might fix an actual (harmless?) bug, if anyone evers
configures a VSTOP or VSTART character with bit 7 set?

    info->x_char =3D ch; // x_char is int, hence sign-extended

transmit_chars() does:

    amiga_custom.serdat =3D info->x_char | 0x100;

which will inadvertently have all high bits sets, including the bit
9, which is only used if PARENB is enabled.  But as it looks like
PARENB handling is broken in amiseral anyway, this doesn't matter
much...

include/linux/tty.h:#define STOP_CHAR(tty) ((tty)->termios.c_cc[VSTOP])
include/linux/tty.h:#define START_CHAR(tty) ((tty)->termios.c_cc[VSTART])

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
