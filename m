Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94381BBBC4
	for <linux-mmc@vger.kernel.org>; Thu, 28 Nov 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807013; cv=none; b=KjvrlXbI7W9J5cy+upT/S8js5I5IczvIV4P7vmq5P2NgVk7ZenUd5jdeBOpX28BXjLQsWZyXTNhDwoynPhgwcNkKafYOxpVwyYP/Y6J+eVDoMFF/KGAmKdWUq+a+01WKFIgkw6aITsUVcXSfnMA2BfLjbI9d5gouYlUKtUNjvdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807013; c=relaxed/simple;
	bh=Ctm1v2XGG+ucVjPxKUudaikXrk6rMN3i6qsDbqS9Y/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rPlCr+R2/AAWUUJGbjABkpeVBIsG0SgPfV6ltAEHJQ5PHjJfjCBcnZycBsyh21YW9HiXmFSq8yDv4PbVL9Y0tTG4iDz2VNm6sQVpo88A8tKqPqMMp/FlVZGV3+YWkMX6xD2jkrYa5N7+Qi5SSMJBJpeYAf11u4f8lBPfCPj/97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kr+b5UrZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kr+b5UrZ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a2033562so8337125e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 Nov 2024 07:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732807010; x=1733411810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S42PGEHBHY2kpBVY5qDRZG4XP5aA8pMSU6efiWvXnew=;
        b=Kr+b5UrZF7Rhp/rc33wyaUvG7ia0ZdBIzsCOsslFHnavSjuAcOFy9/25RL4VSTjc3T
         tStl7ckExVK06JBm03SN6DLzFTeCeo9s/4+2zAoR92RL0Hyr0VYTFTZfnaTqdyeufeQq
         SmwJD7GKYwcp7BpPUG3ltzFMIuCp2YgNB/GZnhWNOUCQTNvX/5RQSM/tbEEpLqkPubJQ
         R3xvDrWVodfLQnYzI3FWfFsrNHwtb+nh/YYjQzkUGfEypV7xqzs/fo9umXcqfPFOmx3O
         w0sVHHgXx6RF2qJJNxvq4M55l02ajj1zNScughaXqjwGPmA0XEI8WzyZu0KxfXA0sPJF
         NVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732807010; x=1733411810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S42PGEHBHY2kpBVY5qDRZG4XP5aA8pMSU6efiWvXnew=;
        b=DO41U4uYHW5UIcS1Zvx46hnYq4Kiu8X31Zvh7GIg7IBs2Jm8n3pgqcWbu3k7nBg9Ak
         so2LSemOvell2URrodvJp7NYOwNTllEQuZ7AAFtzvGtxIyxzf9YymHoQdS/7tgasKeIl
         q0dDQCagFExdF0tWa6IP2z3YpNJK9GCUl4qFhkgkONVQbiKoBiheaO5nMtzgxuHOztEE
         eEcVtAqlNNqpPurb5j9cg3iOWxKwVKYZV03EXzes70NNtsHD7K6yBs+zTzvWL9xQn5wA
         RwThmejqKGzpNrWUQ+Xh9AqnR4KeuiK72b/wvzPhDg62aYJuXkLNjYuP9ncQIGh2F7LO
         BbhA==
X-Gm-Message-State: AOJu0YzVQPOTmki7tPRdYfxJOS9fx4AzmLGUApGidEDYeoZf6gimuWoG
	oPkNpV9mil/G77/J0cn/enUTiZa5F08aHJHqJjWPoDQx6qnWdN97mN2URH29XzU=
X-Gm-Gg: ASbGncs7UHmiqX/3qqajbGzBG8AsAHHIZ/77DEvjiHN85XI+5ZU7Rf21MVGfGjKQvc2
	BbH+zm6P1QM1b5IBN/EaRDFJ7ebMxIgYs/NIbibUitj3yWr5i2Lr4j9pSBHAA1h31sMiO71bK5z
	Ocg5HQ7zIkcwWnKdsYkNdTRQhPMFBfbbbOUuaZxAIpZSMZoCjWEhPcVxUutfHw+QrhWobwZMl2c
	TDfIb2stNVsv20Beq9o7GVESOlShc9IgB5CdwOp3rGxCKc4+ajzacqCBySX82lTX6Yg0yo=
X-Google-Smtp-Source: AGHT+IGXMYu48cPlDHDHNCoxhqcYpYyTwMeAPAwgUmvro+k2EYbKaSdnX+mDxj6JuEry5M6D4bK2CA==
X-Received: by 2002:a05:600c:3146:b0:434:9fac:b158 with SMTP id 5b1f17b1804b1-434a9dbbc0bmr59715305e9.1.1732807010027;
        Thu, 28 Nov 2024 07:16:50 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4fe1sm55867025e9.38.2024.11.28.07.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 07:16:49 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 28 Nov 2024 16:16:43 +0100
Subject: [PATCH v4 3/5] dt-bindings: mmc: controller: remove '|' when not
 needed
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-3-11d9f9200a59@linaro.org>
References: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-0-11d9f9200a59@linaro.org>
In-Reply-To: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-0-11d9f9200a59@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2218;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Ctm1v2XGG+ucVjPxKUudaikXrk6rMN3i6qsDbqS9Y/Q=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnSIlcJoLSEYYm5MQW4xLgZnBP3eyGyvSOl/0RZ/9K
 JJyjN+qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0iJXAAKCRB33NvayMhJ0TLaEA
 CH9I1Fa8qcZ3MWsgMhStJ0f/PPSyNF3vE8CX4dw/J/iF5BymCoCST2eaL3P3SsspJmCQBSU/GbYxRj
 osLZTWfI3J+EDSUOn+HdBdMXs2rYhYq5bHboXwtxFm1iEN7VTQNNOx7Fnaud9YZ3aGTIv6ION4fueg
 Sf4RzG6+sJwrAEIO40zuPr1buajpoO6hJtY4miAwwmjf7kW9B4u7GPv2X79yt3g0m8wFSRgaYn53aD
 lMAHw3kvclnOqYcB+YFbMUPKZee3WO00M04oIiFL7wYq124TUo5pL7o5rKjw2yMx9jHLLRdDTBs8Qe
 eXlNvggZc75XwfmnZNnnInKvrV3iEKqYdhQOqnnLgb87N7BT7GEsqHjQJAiEPecUnRGUtl5frhEhUe
 TPttFVP8KaD6wJ6uf2W0J8hPCLAhyMx3pH9ib6qY++XZHCSAThoxixtSMngbGEOuDuamG1jQqTv8jC
 evJPfaU7uk4kYkU6bjB8iZADcLJfHgz0zUxFLzcdJAPpJ6yWbYNf7X1DylnBjkhpr7+JythyuK3CSJ
 EhoVlvkReBXAuyz2dFzUEi3E3JBOYwzuXx3U0V0BljQ1s8EVBIz38l6P6ZjBL9bc/uZDnisOtFDRsY
 p4H3Llh0+QOUwqjyflnJvR+Sf3NdMV2cRWu4mjtqZKmE7QJ8n32BoU1vkuHQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Adding "|" is used to keep the description format, remove it when
not needed after the split into mmc-controller.yaml and
mmc-controller-common.yaml files.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml | 6 +++---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml        | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index d8297af578049b2bf71cf6e06f45aac1e42bde56..9a72354397591d9648e80806c2f93797abdc70a0 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -9,14 +9,14 @@ title: MMC Controller & Slots Common Properties
 maintainers:
   - Ulf Hansson <ulf.hansson@linaro.org>
 
-description: |
+description:
   These properties are common to multiple MMC host controllers and the
   possible slots or ports for multi-slot controllers.
 
 properties:
   "#address-cells":
     const: 1
-    description: |
+    description:
       The cell is the SDIO function number if a function subnode is used.
 
   "#size-cells":
@@ -321,7 +321,7 @@ patternProperties:
 
     properties:
       compatible:
-        description: |
+        description:
           Name of SDIO function following generic names recommended
           practice
 
diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 99c01ce318d3e5aa914ed9b1b71e620538eef29b..9d7a1298c455434a0848dac32cbe77eb8f71c065 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -9,7 +9,7 @@ title: MMC Controller Common Properties
 maintainers:
   - Ulf Hansson <ulf.hansson@linaro.org>
 
-description: |
+description:
   These properties are common to multiple MMC host controllers. Any host
   that requires the respective functionality should implement them using
   these definitions.

-- 
2.34.1

