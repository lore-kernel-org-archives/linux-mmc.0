Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392202F2E;
	Tue, 30 Sep 2025 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266813; cv=pass; b=Y6Lh8lBJFZZVsbnqzH9VmP1gytdECB229XfXUK182CBWl7gdY6CtqklxbPVc7vxUzlqEVs8miDeZ6Bp5w1K6h8EfDP8Mnrlqn8S31Gg+h74W/YhdI4vUtaKITFlKs7VmcT5Jys4oXfY+fhIqtKJxKZEgkF3ptQUdyKW1wzs1Q1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266813; c=relaxed/simple;
	bh=p4+2uNjB35R2yeMejhwZPZ8iZyWyKs4g1sEXSzTpbF8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=f+S+7eXeiowOHG1KmhVPDPyS6eKfwkSMA1jb8wu2lGKBvPCeUZaLrBjjKzx3T+LARI6/kvpLV435Mj97f2IH5x/SZSKDqEC83lnijUUOvmvgwizNoVzVP/BZzsFahz4DTeJzpSfiOg8nSsoATCrwivPVrfOBHlFtxbxf/52BtGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=hJM1f2ST; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="hJM1f2ST"
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id E3C4B10FB2DD3;
	Wed,  1 Oct 2025 06:13:27 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yz-2FUAqnxxU; Wed,  1 Oct 2025 06:13:24 +0900 (JST)
Received: from webmail.redadmin.org (redadmin.org [192.168.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: weibu@redadmin.org)
	by www.redadmin.org (Postfix) with ESMTPSA id 4E17610F40F4E;
	Wed,  1 Oct 2025 06:13:24 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 www.redadmin.org 4E17610F40F4E
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=192.168.11.50
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1759266804;
	cv=none; b=OTidfFNTZyozohIUeuf7BaTn6zc6+mf9Bh6tM/8rgN2wLZbeY+FqQLlwuocg/Cbn6+bu92MUpwrSuH/Q9xD0QOLQfjJiRrWndD3v+WO8MQwdjNGon1bMYBfDlkZgq8xmoET8d6c7bYoj+5H9GHx/7BKKlyn2To7//jIKodDUyO4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1759266804; c=relaxed/relaxed;
	bh=F4qFODM3c+r4xdS4mUJwKNjV4ZswIR7t6ClHW8ShM9Y=;
	h=DKIM-Filter:DKIM-Signature:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=gcRB/PBmgD2j0nFostj9SEo6YL/Q4AYgKQrGF2B/Xb4crFWReLTsBA7ZGlMrdOIRoojWFC4fK423PnSQWKdBz83lIBxgsCSbR2s9mHhG1ZgFThJAR0auhHrnaQmyBo4yZB7PqMP0aeV0QwuEJ+ppqt1U6iWTqw8nTRToZmEV6EE=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 4E17610F40F4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1759266804;
	bh=F4qFODM3c+r4xdS4mUJwKNjV4ZswIR7t6ClHW8ShM9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hJM1f2ST3i99gxJ7VuKyzgin37ikifcPd1baiFxjFqXYAQ+3NvInpZ97caSGK8288
	 bc8CfI+z0vfcYuVtT1cwRvcBWyJAbJnXyBGYt+y+wVwdkQ9r2ZkZU2FWJbPCr/MsRK
	 9TOvj2OMY5o9JxCkfcXikEtzbsdORawd5cnPYQa8=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 01 Oct 2025 06:13:24 +0900
From: weibu@redadmin.org
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: Correct typo "upto" to "up to"
In-Reply-To: <CAL_JsqL3z7P8YJuqa1tNMYSBRbxWTKfzaDE87FD2+Oe5Thoiog@mail.gmail.com>
References: <20250930134547.1096686-1-weibu@redadmin.org>
 <CAL_JsqL3z7P8YJuqa1tNMYSBRbxWTKfzaDE87FD2+Oe5Thoiog@mail.gmail.com>
Message-ID: <0aa439b55555684c1bddb082a30fb0c6@redadmin.org>
X-Sender: weibu@redadmin.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Of course. Here are the English versions of the reply.

Option 1 (Direct and concise)
Subject: Re: [PATCH] dt-bindings: mmc: Correct typo "upto" to "up to"

Hi Rob,

My apologies, this was sent again by mistake. Please discard this 
version.

There are no changes from the patch I sent yesterday.

Sorry for the noise.

Best regards,

Akiyoshi Kurita


2025-09-30 23:45 に Rob Herring さんは書きました:
> On Tue, Sep 30, 2025 at 8:46 AM Akiyoshi Kurita <weibu@redadmin.org> 
> wrote:
>> 
>> The word "upto" is a typo for "up to". Correct this typo in the
>> mmc-controller-common binding documentation.
> 
> You just sent this yesterday. Why are you sending another version 
> today?
> 
> What changed?
