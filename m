Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F51F582F;
	Tue, 15 Oct 2024 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022550; cv=none; b=VP+tAlHXo5bM0J9hQPsXAinYkQiXX5J4XfHcYSZZ5oEWMlHndcecIlaqM1wxTnOBl1zFcOS2TbbFx9DxOz5WMzaS7x2e/S7FwRYgEfrA/q4mlfgIpefuVC2aHNaadMjfbyvpF3zqZGRvpj8V5m8LlklYv9JIUTlSqsLrdw/DXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022550; c=relaxed/simple;
	bh=4E9KrtJPra18ekGLCafFdTVcdiBBpoXvHXnrngEDQOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLefx5gEly+akC3h2B+63QN4vVeBnKiPJvXEZpZucMob5iv3KJyPA4RtIFaqDYpE15s/t1FR4wW40Efbx7LgcvqcdDxUQ+qgBNIp4ASC4kWoSQhjckR/MOE/9q0o0srI6iWqdXZYzswMMmh2GPekYRaSd6Wa1XxJ06U9XuNe54I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bt/fuR56; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bt/fuR56"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20caea61132so37349955ad.2;
        Tue, 15 Oct 2024 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1729022547; x=1729627347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4E9KrtJPra18ekGLCafFdTVcdiBBpoXvHXnrngEDQOA=;
        b=bt/fuR56jgfZpo2kBsx4OfTyEi/pNCItoYX+QM6kXh+LlVjbOFNeGmJhWN+CvgRPnN
         u6kRYmKNE1ERmLQu2cAylwusP+oExyzN+RDPZ7SUjWpj/+UiHnuVouSx5FdcYgx0wntk
         BDqFNk1XEvR3KLwKGKvxrxvDx1QLLdA5hH6FnZ8Kp4qfeCL3yT53tNX0zcOxGWoCYuJk
         dA9ETCIfEqxAPxMP8m5GZd8Mau4nyybK7nCp7hxuCSzHbk3Y/A2ijALDhqJ/eSInD5TF
         KcFMjrgxSqt+ASBbySi0lMa41a81duqImbbzldjootUs+M7BmDd83LEFWl3Uf84OZCmz
         OgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729022547; x=1729627347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4E9KrtJPra18ekGLCafFdTVcdiBBpoXvHXnrngEDQOA=;
        b=wxhiU1t2Es5gzzFjKcxzIwf1CKzYm4J5t6Kojpp2GnOwZEsgVNaSQsvrnbnzsVadjO
         tegGbMzv04fo2WatwrT7l3Slebtg8azOWMROY3lwAPDV0ag6Cy9gz3myXL0MXhv8iVLv
         SACneMvEfgfn6hrnwLnJeoG+bUynupP9L56JfnWgrcAg466UO+9RocKJjPZIzYuW0B0a
         PItF/1iFE2DvuQZ7k/ViOohrnlkm6wRVpmLVntiY/8ofsp4zV4OHXvkd6rylk08aPlOV
         ueMOCLS1NrF4Sw6VTYSbRjCv3xOVhRDTTygyEefVsShZH5sbmlvnGcmupKSn/V471kEb
         H8OQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2IKjaF/DgEPNi2ehgXvT4/i9RsLW8qZSZzeij4DSjOxf0krTgMOsz95+H93qALWTKQZKgeANfK77n@vger.kernel.org, AJvYcCWENE/eEi6+RDkIHI/1BuWu/vBNk30zVc/DFWCHtOq8Uu8COqJsLcw5jlHf3e4wc7EdnVAZZSnIQyFE3j/K@vger.kernel.org, AJvYcCWVHFnyk1x5Q8XJYcB5ipPQgA4H67ou2urT4A465NSUGUGrX2Lb2sCu9rgEW8H2fpxSn3qv3FblBPBT@vger.kernel.org
X-Gm-Message-State: AOJu0YzZPnypAgzDd7yQxGQopWtehria6jcos3TxTLtCroFZS/5giua4
	vmCY4627bDdun9QEucx2rbeLThg+kEkmbIg+gaYzS9wlwzA71qo7btm1lPds+zxY2RVjCgOMuFE
	fdmWeyFQxkstdN+gD9dPouNA6rn8nPdpt
X-Google-Smtp-Source: AGHT+IFdTSQzdCKXkl2sCIwJ4f6NxCKsUewi9E/3FPVpvhK23o3jahGuP0PQDNUbMudL7f8kYdk05V0AWgHhdzwY6pU=
X-Received: by 2002:a17:902:d489:b0:20b:a25e:16c5 with SMTP id
 d9443c01a7336-20cbb2a0c4emr211703075ad.53.1729022547422; Tue, 15 Oct 2024
 13:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-0-ad4eb22c2a8d@linaro.org>
 <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-3-ad4eb22c2a8d@linaro.org>
In-Reply-To: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-3-ad4eb22c2a8d@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 15 Oct 2024 22:02:16 +0200
Message-ID: <CAFBinCBbq2+_-z3h8r2BA0vxOTLa3qM1KSL29POBr0e9Y6ZexA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt
 to dtschema
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:03=E2=80=AFPM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> Convert the Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
> bindings to dt-schema.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
