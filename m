Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD65155314
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971079; cv=none; b=N6Lw35LZ3qqg5lPDT4bicaIBpYKoNqmyiAk7B7iUj/c8JAmDNqx2jjGWrjkMZfXAzo3cCnNJML6St9vwYQ8ndJawJWebG1c+jO2wuiP5LIVjEKztKt9CpFKHJOr45FBK6pqE1jdR2nSWktKJOJ9dr7o4/D1HE0anLftt4gEWpqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971079; c=relaxed/simple;
	bh=VyNnwnMV7em2aUi0PN4FsqYseyN6NKB+GUEjlxOyWzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/ZEE5ElAkOWZ2dgLs5FfVHXxPYqsX3R9irvL1DYrSogsJTDN36t/zOduvoNcpSed6+QUUb7/2FJgSmPZQgdODiuzSUpMQvfqWUXUBuFBHYkYEsSO3rxYzCiZMe4arIw+MUYF+vaj6GgBfCKmBHrb+JsWlrbHdJ+0VDgzvLhdUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GZOV6a77; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZOV6a77"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e260b266805so1045205276.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2024 08:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727971077; x=1728575877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VyNnwnMV7em2aUi0PN4FsqYseyN6NKB+GUEjlxOyWzc=;
        b=GZOV6a77C84guUxFSSfiB3+pjrCJhBrOwP9y0pXdKMcMVJoyBJRwm5mzVkyWH6a9wN
         H8y7biNVoNNOMuU4j9Oz+zI27fVeipyiAVMrkMTgl+JQLF5xsHsbmOGsla//pukYqlul
         RsANWT1/3iw7pFD0Yt27SmIeyf2KTyWlH9lxk0Q0M8ky/tsu4xY/0JTmgruweDqvLgC6
         Amw4Aa/Y+wC3NXsC7au8jRcdUGM8F+M1VTpPZb+EOqeaZ4MJJXo8FmTvnl/EF0IDLcC/
         48/U9VB1VTgz3JGaN/J+tDde+WBzvoAb2/ruhpIIZV8rnDgkD5qJ5gkmIeoYPLcAPTEx
         393A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971077; x=1728575877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyNnwnMV7em2aUi0PN4FsqYseyN6NKB+GUEjlxOyWzc=;
        b=plgSS2T9EK8CF6AF0vDehHdpFOVEO7X1SkLRwJe62QhZ/bEutR8dldzOkOQTF5rFYC
         5/UnPODFUcE7PG4M3/IxNY6sPsJ8Loyk14ltjQdgrCpAWjYaczZZH8TqNVJfD2e+kG3+
         oJuuNZoSejoAnKOW6BTI1SgRiPnWt7HkKNp0qLaL0tG5WHJiFSZf0uvbXMsOsbgwGKfz
         LmyMHgo6zO/ltC5IrwfSeVV2AKwPNnG8Ip2e7yi6V9/INukmkdUVZzlyYTHMAZhoFoF3
         KzSsuMU1lnXs/QyIGI1wHuX1EM03maw6Aqk4uPPa1SHXUCyfKGSyJBfOo/EwacjELJaF
         832w==
X-Forwarded-Encrypted: i=1; AJvYcCWLNorjcfGm7TMVEy2VHBSVgP1mxLzO8eFhcE9tuDWVqW7PKyfjOw09pBrWgHo7iZ7h4qLkOyQuz2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YynF/ZmkGuwGy198w4O/WrtKUcMbkBpkF0HZhCrDHVqm8w4/BP2
	OfJv3CoNVqHrZT81GUb15bTu4biCi9b6Tl3clNqJJ1BO3GH8zPqgQWmw092vZ4FPEEyq2YkRhq5
	5taeiBVLGNDNEiPXsy+NbraFZFnhEZq1WYnaegbUGvMvMQBnSPS4=
X-Google-Smtp-Source: AGHT+IFUbx6qJBXHUcQFlBGhIyGy+qw4mWmRoAHA9COr5VN2GH/EH8vJJIJ3AJfA1xGDwZpVIIVc2wuwnqXQvsVhc0U=
X-Received: by 2002:a05:6902:1ac5:b0:e21:2cd3:803d with SMTP id
 3f1490d57ef6-e2638416bcemr5878686276.35.1727971076718; Thu, 03 Oct 2024
 08:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908102018.3711527-1-avri.altman@wdc.com> <20240908102018.3711527-10-avri.altman@wdc.com>
 <6cb63826-e6b4-4e3b-92e3-5a5c912eedea@arm.com> <DM6PR04MB65759D7DE903446671DF8D1EFC982@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65759D7DE903446671DF8D1EFC982@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 17:57:20 +0200
Message-ID: <CAPDyKFr8--BF6MrN7pyutziU9BNwPQLEi9QJ6Y2FT_jbSD9asA@mail.gmail.com>
Subject: Re: [PATCH v7 09/10] mmc: core: Prevent HSQ from enabling for SDUC
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Christian Loehle <christian.loehle@arm.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Sept 2024 at 14:11, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > On 9/8/24 11:20, Avri Altman wrote:
> > > Prevent Host Software Queue from enabling for SDUC. In SDUC, CMD44 is
> > > modified to include 6-bit upper address by utilizing its reserved bits.
> > > Exclude hsq for SDUC for now.
> >
> > The message here is misleading, actually hsq has nothing to do with the actual CQ
> > as in CMD44, it's just a hack to present itself to the mmc subsystem as such to
> > then get more in-flight requests from mmc core, which can be prepared in
> > advance and be issued asynchronously to the completion of the preceding
> > request (in atomic context). So the card is completely oblivious to hsq.
> > This is presumably broken though by the mandatory CMD22 for SDUC.
> Thanks.
> Somehow, I thought that hsq relies on hw command queue engine.
> If totally necessary, I will fix it in the next spin.

I suggest we at least update the commit message so we understand why
we don't allow hsq for SDUC. It seems possible to make it work for
hsq, but I don't mind if we consider that as an improvement on top of
the initial support for SDUC.

Does that make sense?

[...]

Kind regards
Uffe
