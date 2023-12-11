Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFD0A9;
	Mon, 11 Dec 2023 02:39:49 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BBAboiQ72682855, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BBAboiQ72682855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 18:37:50 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 11 Dec 2023 18:37:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 11 Dec 2023 18:37:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 11 Dec 2023 18:37:50 +0800
From: =?utf-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "asutoshd@codeaurora.org"
	<asutoshd@codeaurora.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "briannorris@chromium.org"
	<briannorris@chromium.org>,
        "doug@schmorgal.com" <doug@schmorgal.com>,
        "tonyhuang.sunplus@gmail.com" <tonyhuang.sunplus@gmail.com>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "william.qiu@starfivetech.com"
	<william.qiu@starfivetech.com>
Subject: RE: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
Thread-Topic: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host
 driver
Thread-Index: AQHaHFq+bFd/3O/jHUaixlBEulhIvbCPjA6AgArwJkD//6DXgIAJ4hcQ
Date: Mon, 11 Dec 2023 10:37:49 +0000
Message-ID: <49d0b19c5ec741638e41ee6f970d057b@realtek.com>
References: <20231121091101.5540-1-jyanchou@realtek.com>
 <20231121091101.5540-3-jyanchou@realtek.com>
 <655c5964-0917-4021-b254-7917b368b05f@intel.com>
 <7b4b7219c2b6430b9c320c8d9ac1cc8b@realtek.com>
 <8e7b6ac2-9d92-4f37-97c4-ae295f7cdbd4@intel.com>
In-Reply-To: <8e7b6ac2-9d92-4f37-97c4-ae295f7cdbd4@intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

SGkgQWRyaWFuLA0KDQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBpcnFyZXR1cm5fdCBkd19tY2lfY3Fl
X2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpkZXZfaWQpIHsNCj4+Pj4gKyAgICAgc3RydWN0IGR3
X21jaSAqaG9zdCA9IGRldl9pZDsNCj4+Pj4gKyAgICAgc3RydWN0IG1tY19ob3N0ICptbWMgPSBo
b3N0LT5zbG90LT5tbWM7DQo+Pj4+ICsgICAgIHN0cnVjdCBjcWhjaV9ob3N0ICpjcV9ob3N0ID0g
TlVMTDsNCj4+Pj4gKyAgICAgaW50IGNtZF9lcnJvciA9IDAsIGRhdGFfZXJyb3IgPSAwOw0KPj4+
PiArDQo+Pj4+ICsgICAgIGlmIChob3N0LT5wZGF0YSAmJiAoaG9zdC0+cGRhdGEtPmNhcHMyICYg
TU1DX0NBUDJfQ1FFKSkNCj4+Pj4gKyAgICAgICAgICAgICBjcV9ob3N0ID0gbW1jLT5jcWVfcHJp
dmF0ZTsNCj4+Pj4gKw0KPj4+PiArICAgICBkd19tY2lfZ2V0X2ludChob3N0KTsNCj4+Pj4gKw0K
Pj4+PiArICAgICBpZiAoaG9zdC0+cGRhdGEgJiYgKGhvc3QtPnBkYXRhLT5jYXBzMiAmIE1NQ19D
QVAyX0NRRSkpIHsNCj4+Pj4gKyAgICAgICAgICAgICBpZiAoIW1tYy0+Y3FlX29uICYmICFjcV9o
b3N0LT5hY3RpdmF0ZWQpDQo+Pj4NCj4+PiBTaG91bGRuJ3QgcmVhbGx5IGxvb2sgYXQgaW50ZXJu
YWxzIGxpa2UgbW1jLT5jcWVfb24gb3IgY3FfaG9zdC0+YWN0aXZhdGVkLg0KPj4+IFRoZXJlIGFy
ZSB0aGUgY3FoY2lfaG9zdF9vcHMgLT5lbmFibGUoKSBhbmQgLT5kaXNhYmxlKCkgY2FsbGJhY2tz
IHRvDQo+Pj4ga2VlcCB0cmFjayBvZiB3aGV0aGVyIGNxaGNpIGlzIGV4cGVjdGluZyBpbnRlcnJ1
cHRzLg0KPj4NCj4+IERvZXMgdGhpcyBtZWFucyB3ZSBuZWVkIHRvIHVzZSBjcWhjaV9ob3N0X29w
cyAtPmVuYWJsZSgpIGFuZA0KPj4gLT5kaXNhYmxlKCkgY2FsbGJhY2tzIGluc3RlYWQgb2YgbW1j
LT5jcWVfb24gJiYgIWNxX2hvc3QtPmFjdGl2YXRlZD8NCj5UaGFua3MuDQo+DQo+WWVzLiAgLT5l
bmFibGUoKSBpcyBhbHdheXMgY2FsbGVkIGJlZm9yZSBjcWhjaSBvcGVyYXRpb24gYW5kIC0+ZGlz
YWJsZSgpIGJlZm9yZQ0KPm5vbi1jcWhjaSBvcGVyYXRpb24sIHNvIHRoZXkgY2FuIGJlIHVzZWQg
dG8gZGV0ZXJtaW5lIGlmIGFuIGludGVycnVwdCBpcyBmb3INCj5jcWhjaS4NCg0KVGhhbmtzIGZv
ciB5b3VyIGFkdmljZSwgYW5kIEkgZ290IHlvdXIgcG9pbnQgZm9yIGNhbGxpbmcgY3FoY2lfaG9z
dF9vcHMgLT5lbmFibGUoKQ0KDQphbmQgLT5kaXNhYmxlKCkgY2FsbGJhY2tzLCBidXQgdGhlIHJl
YXNvbiB3ZSB1c2VkICIgaWYgKCFtbWMtPmNxZV9vbiAmJiAhY3FfaG9zdC0+YWN0aXZhdGVkKSAi
DQoNCmlzIHRoYXQgd2hlbiBzZW5kaW5nIGNvbW1hbmQgbGlrZSBjbWQwLCAxLCA3LCA4Li4uIGlu
IG1tY19pbml0X2NhcmQgYmVmb3JlIG1tY19jbWRxX2VuYWJsZSwNCg0Kd2UgbmVlZCB0byB1c2Ug
aW50ZXJydXB0IGluIGxlZ2FjeSBtb2RlLCBpdCBpcyBtdWNoIGJldHRlciB0byB3cml0ZSBpbiB0
aGlzIHdheT8NCg0KKwlldmVudHMgPSBtY2lfcmVhZHcoaG9zdCwgTk9STUFMX0lOVF9TVEFUX1Ip
Ow0KLSAJaWYgKGhvc3QtPnBkYXRhICYmIChob3N0LT5wZGF0YS0+Y2FwczIgJiBNTUNfQ0FQMl9D
UUUpKSB7DQotIAkJaWYgKCFtbWMtPmNxZV9vbiAmJiAhY3FfaG9zdC0+YWN0aXZhdGVkKQ0KKwlp
ZiAobW1jLT5jYXBzMiAmIE1NQ19DQVAyX0NRRSkgew0KKwkJaWYgKCEoZXZlbnRzICYgQ1FFX0VW
RU5UKSkNCgkJCWR3X21jaV9jbHJfc2lnbmFsX2ludChob3N0KTsNCg0KVXNpbmcgQ1FFX0VWRU5U
IHRvIGRldGVybWluZSB3aGV0aGVyIENvbW1hbmQgUXVldWUgZW5hYmxlIG9yIG5vdC4NCg0KTWFu
eSB0aGFua3MuDQoNCkJlc3QgUmVnYXJkcywNCkp5YW4NCg==
