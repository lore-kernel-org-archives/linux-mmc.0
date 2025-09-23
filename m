Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B21ADC97
	for <linux-mmc@vger.kernel.org>; Wed, 24 Sep 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674623; cv=pass; b=ronFC8TsUpV/nVRntahKf8wzb5jB5bPFCgh7KGvXojwARoJPPWOakTvN9XnwXMUf36/FVoElDC79xv2phuL7PaUfbt26/a9bgh2TzVL9hSA50nu3KT5x2Fz3FN0GiltKHox4uDdeDRaLgOx4GkNvFLvtjqhAQI0LJfsAmnoiPrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674623; c=relaxed/simple;
	bh=e9jCbgHbNQ8/gkJ9ojwm2fJ0ALLWC9z3q7akMYhyHwc=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=sVqs0fZYgK77dYKKZ0jfV86OmVaTT/n5b5mWfM1Ym3sEIPnZhqkupeYIp6HtNbBzjDClg8Z5zo4sEkxSleNd7pxooivKdx3qxP9yB9fncqt5zxgAY8A3ObikEzQHMdqpcHyv0DGXt+zHzcYAiDBEqoJQsLysHMpyWWJ5BMIxyXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=bWi+NqtO; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="bWi+NqtO"
ARC-Seal: i=1; a=rsa-sha256; t=1758674620; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=TYaU+XNOWOOLXgJg8IkywJF48hqF4P9BHoUkMHoBfG1GYNQsUxsUs1Qn6fLvbx6Dh6lC0lTGuf5oIKrkz1D9uM68EnyRtoGy5KXWSFOGSSJ7AOICKzluDpPy2ilYW3Y5T0HWpUpSXTX5bHJudjBm4Jw4wcSlRUITMbJzJEoqfRA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674620; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=e9jCbgHbNQ8/gkJ9ojwm2fJ0ALLWC9z3q7akMYhyHwc=; 
	b=jdIFfxa5AaQVUkhzkcuOj4dRJBXyWyRSUDi9HsQbbD9g2GLxK5wks5i+eiIHJ/SKMbOJT075xo/vGKnXR2asLG4h3dvliFJ3KhbI5sofVNE34kc29C8IQ+f5NUzLh/vhbwjvxXRuYH6J1jeo5ljhnXt8rineeKsIxK1N8VbVOOw=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9a985dc0-98d8-11f0-9ce0-52540088df93_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653600592.8597185224347;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=bWi+NqtOQm660DZ8ipzdHLlW557Mqa7hbg8pxXrAAP/XXi9qXju10Ia80+PcApXX8btXDd6al98heEcgmWkxhPoSWTOcG4evbPSD9WIsx7fsL8rJDEXpUQ5t9oRqVJSmTB29SNj+t5IPLPhHVCosG/SZw08h0hF/IoP6Vrw8WfQ=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=e9jCbgHbNQ8/gkJ9ojwm2fJ0ALLWC9z3q7akMYhyHwc=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-mmc@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9a985dc0-98d8-11f0-9ce0-52540088df93.19978ffc59c@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9a985dc0-98d8-11f0-9ce0-52540088df93.19978ffc59c
X-JID: 2d6f.1aedd99b146bc1ac.s1.9a985dc0-98d8-11f0-9ce0-52540088df93.19978ffc59c
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9a985dc0-98d8-11f0-9ce0-52540088df93.19978ffc59c
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9a985dc0-98d8-11f0-9ce0-52540088df93.19978ffc59c
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9a985dc0-98d8-11f0-9ce0-52540088df93.19978ffc59c@zeptomail.com>
X-ZohoMailClient: External

To: linux-mmc@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director
