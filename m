Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A08BEB64DC
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jun 2023 20:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjFYUrr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jun 2023 16:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFYUrq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Jun 2023 16:47:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1D9113
        for <linux-mmc@vger.kernel.org>; Sun, 25 Jun 2023 13:47:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9883123260fso241425966b.0
        for <linux-mmc@vger.kernel.org>; Sun, 25 Jun 2023 13:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687726064; x=1690318064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AqFVIF9YfIBYb2CvrHHDuEqSvWmX+/UHXMYkRoIX+s=;
        b=DV0fQxhtxizfrMX3uu1W6cPFSovBnbE7sMjSDJtut5hLi292pSAOMKfV5GT8SNWFnt
         y6on8ZGRC9OjJB8ctc53gUApt9/YNintfY5SslcLS13Lx4Amw1SIDwKZKbVzr8KyPdhp
         DNu4bN0CwpzMutuCCUAppyLMO8ltVP+7yBShkx7/P3V0ezQw0VfGnif9jlXZkNbP9U6x
         3XMbHNAjTtH6o8tyRvbcDJi7P1ojXrC5b65BFD+XfGwx/nwjP4y/Ofyvz/8EzGZYe4Vu
         sBVvKAOyi/hiyQJjYafQgZLjvkRfATB1ad8duQLnnJr1C+DtMz639kttYIKKE+DptaHx
         78zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687726064; x=1690318064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AqFVIF9YfIBYb2CvrHHDuEqSvWmX+/UHXMYkRoIX+s=;
        b=BLRAmIu/thmodWk7JPgbH9xutThlAMK6ZgyftpIgxsL8KtLsKj8mHDuwP9Nky9yaOb
         kcA6eEAa34eSYXd7XYH2+GSH9f2xSN9lZSERmoddWNjiuJTGFCtxX3Nnd0OuA7k8jttU
         VQzQ4m1OTZPiyq/lEG4Jw/JDVpPmBxXVUf9B682IDXBHYnXWJBJS/sIemk89BRwaqWNc
         j7epAhMbaxMX/0RRCUq39AsXCeZr24HvcZfONVc5TbUTQrw6Pxj5yrB0X2PhfdwDK9wV
         JLJJ+/U/MrKRL0M4qccDmQFA4on9t6J4tLp9V98kgxsX8RYuBAgZdNd6W/d1J6XojSwp
         ZOmg==
X-Gm-Message-State: AC+VfDx9pZ3OzmRnGmaU0lA9DKRIUFtSlg43JF/1dji+lr9Q7SYpAqVG
        cp1YQQLi0J7RKErGzv1+xHgC1ztD1ubycMEZv7Y=
X-Google-Smtp-Source: ACHHUZ4dJTnQ+e5HK62iMwxzgdg8edVG5dR+IlPYW/YhSwjjl+dJxjkTY/D2/YtWl6RZz4GhPmx9nZZ4MLpq36fvcTk=
X-Received: by 2002:a17:907:2d11:b0:988:8a02:4560 with SMTP id
 gs17-20020a1709072d1100b009888a024560mr15820644ejc.44.1687726063835; Sun, 25
 Jun 2023 13:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230622105327.77296-1-ulf.hansson@linaro.org>
In-Reply-To: <20230622105327.77296-1-ulf.hansson@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Jun 2023 22:47:33 +0200
Message-ID: <CAFBinCAULmVZJ0Zt5J=kmr11qeudeYgf=57y9esCaH9M5jJLpw@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: Drop redundant WARN_ON() in the irq handler
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jun 22, 2023 at 12:53=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> The host pointer is already being dereferenced earlier, so let's just dro=
p
> the redundant WARN_ON.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
