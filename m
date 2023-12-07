Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hk6K+MZl"
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDC11994
	for <linux-mmc@vger.kernel.org>; Thu,  7 Dec 2023 06:17:22 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5d3644ca426so7873597b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 07 Dec 2023 06:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701958642; x=1702563442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bsCcuGLo2J2I6ix+dXxn7SDWpUwAIlNPbaC4IivWIA8=;
        b=Hk6K+MZlCrBOJJDwgyumD2wg5DmNF82fqjyHW0SDGmzbrpjcmTPpeNyXN8UEL9dk6E
         naiq1grlAHhLSJvQlapEAxJojBDwtMLTjWcxCARqsVIlaTOPgNrlkReyzGG/37icBL8a
         EfJ+APQPxxTaNOBp6HgOWpe8ZSSVc6LOwla/8oHCb7Ayv6FBkNrgh7hrLBS1cA5Ircqv
         /bM5r1kztB9QQkaCG/yPkc8QjhAUSGd2PSE+scPTQlsarPjFlsK7wtwTCyAVAITRwBgS
         kRjsqgr8GMz6vpcjf5ynIV1lirq5/LwiggWcYgqwpRS/i6AcaEXOJz+jfBaP1YplDL3I
         XZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958642; x=1702563442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsCcuGLo2J2I6ix+dXxn7SDWpUwAIlNPbaC4IivWIA8=;
        b=kxDj3NwBjmnE0Il3vq4kEo2KRJzcBCiK9S8Jvypf9zVQ7egdE75iJimVxLUnElbA5G
         QW4bl/hPBcEAqNcQ8iLX7Pa5InRNd9JBtkWJYti2HjJxHJ7G61ypgwEfULhpQUDNRz+J
         YrbHeLYZ8yGySKfv+yWj8svfXeUVnheKRCyrKsK7+7sqCHTXS0FEHCxSpAxmppH17jDm
         WS5q4sdeKSxLFIsFZaDlZ01iqbgNMxPVN97ftR/bQGK2za3qIe1S3eCNl5Mmr5H6+hy5
         M8JBkk2nepMT1L8Uq1gkD/ZQ4uBrclzS9WuKG8dtz2IR1j2hHohVVyn2KHytzpeVPxCS
         GFrg==
X-Gm-Message-State: AOJu0Ywc/qhwVkYTdjlsI+7IMscFJYsnFV8M+wbysvHubKCuMhnrbEUi
	nlOHLRTT50TKETOu+GIrBys2GGEuZ/PDij5X56ERgA==
X-Google-Smtp-Source: AGHT+IEBRQ4AL/XFd1LTfykGK68U5ukkx7PsrewbOYUyuvwi8DZONr9x4L/XICW9RDrsS4gnNobATSOqQIlk4jIDe8A=
X-Received: by 2002:a05:690c:c0d:b0:59d:d85e:795d with SMTP id
 cl13-20020a05690c0c0d00b0059dd85e795dmr2665100ywb.51.1701958641855; Thu, 07
 Dec 2023 06:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207063535.29546-1-axe.yang@mediatek.com>
In-Reply-To: <20231207063535.29546-1-axe.yang@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 7 Dec 2023 15:16:46 +0100
Message-ID: <CAPDyKFoFexzhQ59O-v1X_QjgztYZbHfQtKqGKsHsnmU6Bf75YQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] mmc: mediatek: add support for 64-steps tuning
To: Axe Yang <axe.yang@mediatek.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Dec 2023 at 07:35, Axe Yang <axe.yang@mediatek.com> wrote:
>
> Change in v4:
> - for SD/SDIO, tune 64 steps by default
> - reduce some breaks to improve code readability
>
> Change in v3:
> - use BIT_ULL() instead of BIT() to avoid potential left shift operations
>   that could cause exceed boundary problem on 32-bit platforms
>
> Change in v2:
> - move the change made to document to the front
> - change mediatek,tune-step dts property type to enum for better scalability
>
> Axe Yang (2):
>   dt-bindings: mmc: mtk-sd: add tuning steps related property
>   mmc: mediatek: extend number of tuning steps
>
>  .../devicetree/bindings/mmc/mtk-sd.yaml       |   9 +
>  drivers/mmc/host/mtk-sd.c                     | 158 ++++++++++++------
>  2 files changed, 119 insertions(+), 48 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
